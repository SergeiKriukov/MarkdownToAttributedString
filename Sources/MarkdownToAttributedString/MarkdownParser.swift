import Foundation

/// Основной парсер Markdown текста
public class MarkdownParser {

    public init() {}

    /// Парсит Markdown текст и возвращает массив элементов
    public func parse(_ markdown: String) -> [MarkdownElement] {
        let lines = markdown.components(separatedBy: .newlines)
        var elements: [MarkdownElement] = []
        var currentListNumber = 0

        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)

            if trimmedLine.isEmpty {
                elements.append(MarkdownElement(type: .lineBreak, content: "\n"))
                continue
            }

            // Парсим заголовки (# Header)
            if let headerElement = parseHeader(trimmedLine) {
                elements.append(headerElement)
                continue
            }

            // Парсим маркированные списки (- item или * item)
            if let listElement = parseUnorderedList(trimmedLine) {
                elements.append(listElement)
                continue
            }

            // Парсим нумерованные списки (1. item)
            if let listElement = parseOrderedList(trimmedLine, currentNumber: &currentListNumber) {
                elements.append(listElement)
                continue
            }

            // Парсим кодовые блоки (```code```)
            if let codeBlockElement = parseCodeBlock(trimmedLine) {
                elements.append(codeBlockElement)
                continue
            }

            // Парсим обычный текст с inline элементами
            let inlineElements = parseInlineElements(trimmedLine)
            if !inlineElements.isEmpty {
                // Создаем параграф с inline элементами
                let paragraph = MarkdownElement(type: .paragraph, content: "")
                elements.append(paragraph)
                elements.append(contentsOf: inlineElements)
            }
        }

        return elements
    }

    // MARK: - Private Methods

    private func parseHeader(_ line: String) -> MarkdownElement? {
        guard line.hasPrefix("#") else { return nil }

        let hashCount = line.prefix(while: { $0 == "#" }).count
        guard hashCount >= 1 && hashCount <= 6 else { return nil }

        let content = line.dropFirst(hashCount).trimmingCharacters(in: .whitespaces)
        guard !content.isEmpty else { return nil }

        return MarkdownElement(type: .header(level: hashCount), content: content)
    }

    private func parseUnorderedList(_ line: String) -> MarkdownElement? {
        guard line.hasPrefix("- ") || line.hasPrefix("* ") || line.hasPrefix("+ ") else { return nil }

        let content = String(line.dropFirst(2))
        let inlineElements = parseInlineElements(content)
        return MarkdownElement(type: .unorderedList(content: inlineElements), content: "")
    }

    private func parseOrderedList(_ line: String, currentNumber: inout Int) -> MarkdownElement? {
        let pattern = "^(\\d+)\\.\\s+(.+)$"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []),
              let match = regex.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.count)) else {
            return nil
        }

        let numberRange = Range(match.range(at: 1), in: line)!
        let contentRange = Range(match.range(at: 2), in: line)!

        guard let number = Int(line[numberRange]) else { return nil }

        currentNumber = number
        let content = String(line[contentRange])
        let inlineElements = parseInlineElements(content)

        return MarkdownElement(type: .orderedList(number: number, content: inlineElements), content: "")
    }

    private func parseCodeBlock(_ line: String) -> MarkdownElement? {
        guard line.hasPrefix("```") else { return nil }

        let content = String(line.dropFirst(3))
        return MarkdownElement(type: .codeBlock, content: content)
    }

    private func parseInlineElements(_ line: String) -> [MarkdownElement] {
        var elements: [MarkdownElement] = []
        var currentText = ""
        var i = 0
        let chars = Array(line)

        while i < chars.count {
            switch chars[i] {
            case "`":
                // Инлайновый код (`code`)
                if !currentText.isEmpty {
                    elements.append(MarkdownElement(type: .text, content: currentText))
                    currentText = ""
                }

                if let endIndex = findInlineCodeEnd(chars, start: i + 1) {
                    let codeContent = String(chars[(i + 1)..<endIndex])
                    elements.append(MarkdownElement(type: .code, content: codeContent))
                    i = endIndex + 1
                } else {
                    currentText.append(chars[i])
                    i += 1
                }

            case "[":
                // Ссылки [title](url)
                if let linkElement = parseLink(chars, startIndex: i) {
                    if !currentText.isEmpty {
                        elements.append(MarkdownElement(type: .text, content: currentText))
                        currentText = ""
                    }
                    elements.append(linkElement.element)
                    i = linkElement.endIndex
                } else {
                    currentText.append(chars[i])
                    i += 1
                }

            case "!":
                // Изображения ![title](url)
                if i + 1 < chars.count && chars[i + 1] == "[" {
                    if let imageElement = parseImage(chars, startIndex: i) {
                        if !currentText.isEmpty {
                            elements.append(MarkdownElement(type: .text, content: currentText))
                            currentText = ""
                        }
                        elements.append(imageElement.element)
                        i = imageElement.endIndex
                    } else {
                        currentText.append(chars[i])
                        i += 1
                    }
                } else {
                    currentText.append(chars[i])
                    i += 1
                }

            case "*", "_":
                // Жирный и курсив (**bold**, *italic*)
                let marker = chars[i]
                if let styleElement = parseStyle(chars, startIndex: i, marker: marker) {
                    if !currentText.isEmpty {
                        elements.append(MarkdownElement(type: .text, content: currentText))
                        currentText = ""
                    }
                    elements.append(styleElement.element)
                    i = styleElement.endIndex
                } else {
                    currentText.append(chars[i])
                    i += 1
                }

            default:
                currentText.append(chars[i])
                i += 1
            }
        }

        if !currentText.isEmpty {
            elements.append(MarkdownElement(type: .text, content: currentText))
        }

        return elements
    }

    private func findInlineCodeEnd(_ chars: [Character], start: Int) -> Int? {
        for i in start..<chars.count {
            if chars[i] == "`" {
                return i
            }
        }
        return nil
    }

    private func parseLink(_ chars: [Character], startIndex: Int) -> (element: MarkdownElement, endIndex: Int)? {
        guard startIndex + 1 < chars.count else { return nil }

        // Находим конец title
        guard let titleEnd = findClosingBracket(chars, start: startIndex + 1) else { return nil }

        // Проверяем наличие (
        guard titleEnd + 1 < chars.count && chars[titleEnd + 1] == "(" else { return nil }

        // Находим конец url
        guard let urlEnd = findClosingParenthesis(chars, start: titleEnd + 2) else { return nil }

        let title = String(chars[(startIndex + 1)..<titleEnd])
        let url = String(chars[(titleEnd + 2)..<urlEnd])

        let element = MarkdownElement(type: .link(title: title, url: url), content: title)
        return (element, urlEnd + 1)
    }

    private func parseImage(_ chars: [Character], startIndex: Int) -> (element: MarkdownElement, endIndex: Int)? {
        guard startIndex + 2 < chars.count else { return nil }

        // Находим конец title
        guard let titleEnd = findClosingBracket(chars, start: startIndex + 2) else { return nil }

        // Проверяем наличие (
        guard titleEnd + 1 < chars.count && chars[titleEnd + 1] == "(" else { return nil }

        // Находим конец url
        guard let urlEnd = findClosingParenthesis(chars, start: titleEnd + 2) else { return nil }

        let title = String(chars[(startIndex + 2)..<titleEnd])
        let url = String(chars[(titleEnd + 2)..<urlEnd])

        let element = MarkdownElement(type: .image(title: title, url: url), content: title)
        return (element, urlEnd + 1)
    }

    private func parseStyle(_ chars: [Character], startIndex: Int, marker: Character) -> (element: MarkdownElement, endIndex: Int)? {
        let isDouble = startIndex + 1 < chars.count && chars[startIndex + 1] == marker
        let markerLength = isDouble ? 2 : 1

        // Ищем закрывающий маркер
        guard let endIndex = findStyleEnd(chars, start: startIndex + markerLength, marker: marker, isDouble: isDouble) else {
            return nil
        }

        let content = String(chars[(startIndex + markerLength)..<endIndex])
        let type: MarkdownElementType = isDouble ? .bold : .italic

        let element = MarkdownElement(type: type, content: content)
        return (element, endIndex + markerLength)
    }

    private func findClosingBracket(_ chars: [Character], start: Int) -> Int? {
        for i in start..<chars.count {
            if chars[i] == "]" {
                return i
            }
        }
        return nil
    }

    private func findClosingParenthesis(_ chars: [Character], start: Int) -> Int? {
        for i in start..<chars.count {
            if chars[i] == ")" {
                return i
            }
        }
        return nil
    }

    private func findStyleEnd(_ chars: [Character], start: Int, marker: Character, isDouble: Bool) -> Int? {
        let markerLength = isDouble ? 2 : 1

        for i in start..<chars.count {
            if i + markerLength - 1 < chars.count {
                var isMatch = true
                for j in 0..<markerLength {
                    if chars[i + j] != marker {
                        isMatch = false
                        break
                    }
                }
                if isMatch {
                    return i
                }
            }
        }
        return nil
    }
}
