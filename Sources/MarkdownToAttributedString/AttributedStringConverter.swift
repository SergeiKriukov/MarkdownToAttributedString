import Foundation

/// Конвертер Markdown элементов в NSAttributedString
class AttributedStringConverter {

    private let configuration: MarkdownConfiguration

    public init(configuration: MarkdownConfiguration = .init()) {
        self.configuration = configuration
    }

    /// Конвертирует массив Markdown элементов в NSAttributedString
    public func convert(_ elements: [MarkdownElement]) -> NSAttributedString {
        let result = NSMutableAttributedString()

        for element in elements {
            let attributedString = createAttributedString(for: element)
            result.append(attributedString)
        }

        return result
    }

    /// Конвертирует Markdown строку в NSAttributedString
    public func convert(_ markdown: String) -> NSAttributedString {
        let parser = MarkdownParser()
        let elements = parser.parse(markdown)
        return convert(elements)
    }

    // MARK: - Private Methods

    private func createAttributedString(for element: MarkdownElement) -> NSAttributedString {
        var content = element.content

        // Применяем стиль в зависимости от типа элемента
        switch element.type {
        case .text:
            break

        case .header(let level):
            // Для заголовков добавляем префикс уровня
            content = String(repeating: "#", count: level) + " " + content

        case .bold:
            content = "**\(content)**"

        case .italic:
            content = "*\(content)*"

        case .code:
            content = "`\(content)`"

        case .codeBlock:
            content = "```\n\(content)\n```"

        case .link(let title, let url):
            content = "[\(title)](\(url))"

        case .image(let title, let url):
            content = "![\(title)](\(url))"

        case .unorderedList:
            content = "• \(content)"

        case .orderedList(let number):
            content = "\(number). \(content)"

        case .lineBreak:
            content = "\n"

        case .paragraph:
            break

        case .table:
            // Таблицы пока не реализованы - возвращаем как текст
            break
        }

        return NSAttributedString(string: content)
    }
}
