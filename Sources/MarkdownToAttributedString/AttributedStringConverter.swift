import Foundation
#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

/// Конвертер Markdown элементов в NSAttributedString
class AttributedStringConverter {

    private let configuration: MarkdownConfiguration

    public init(configuration: MarkdownConfiguration = .init()) {
        self.configuration = configuration
    }

    // MARK: - Helper Methods for Font Creation

    private func fontAttributes(for style: MarkdownStyle) -> [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [:]

        // Создаем шрифт на основе стиля
        #if canImport(UIKit)
            // iOS, tvOS, watchOS
            var font: UIFont

            // Применяем вес шрифта
            let weight: UIFont.Weight
            switch style.fontWeight {
            case .regular:
                weight = .regular
            case .bold:
                weight = .bold
            case .semibold:
                weight = .semibold
            case .light:
                weight = .light
            }

            font = UIFont.systemFont(ofSize: style.fontSize, weight: weight)

            // Применяем курсив, если нужно
            if style.isItalic {
                if let descriptor = font.fontDescriptor.withSymbolicTraits(.traitItalic) {
                    font = UIFont(descriptor: descriptor, size: style.fontSize)
                }
            }

            attributes[.font] = font
        #elseif canImport(AppKit)
            // macOS
            var font: NSFont

            // Применяем вес шрифта
            switch style.fontWeight {
            case .regular:
                font = NSFont.systemFont(ofSize: style.fontSize)
            case .bold:
                font = NSFont.boldSystemFont(ofSize: style.fontSize)
            case .semibold:
                font = NSFont.systemFont(ofSize: style.fontSize, weight: .semibold)
            case .light:
                font = NSFont.systemFont(ofSize: style.fontSize, weight: .light)
            }

            // Применяем курсив, если нужно
            if style.isItalic {
                let italicFont = NSFontManager.shared.convert(font, toHaveTrait: .italicFontMask)
                font = italicFont
            }

            attributes[.font] = font
        #endif

        return attributes
    }

    /// Конвертирует массив Markdown элементов в NSAttributedString
    public func convert(_ elements: [MarkdownElement]) -> NSAttributedString {
        let result = NSMutableAttributedString()

        for (index, element) in elements.enumerated() {
            let attributedString = createAttributedString(for: element)
            result.append(attributedString)
            
            // Добавляем перенос строки после параграфа, если следующий элемент не является inline
            if case .paragraph = element.type {
                let nextElement = index + 1 < elements.count ? elements[index + 1] : nil
                if nextElement == nil {
                    result.append(NSAttributedString(string: "\n"))
                } else {
                    switch nextElement!.type {
                    case .header, .paragraph, .unorderedList, .orderedList:
                        result.append(NSAttributedString(string: "\n"))
                    default:
                        break
                    }
                }
            }
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
        let content = element.content
        var attributes: [NSAttributedString.Key: Any] = [:]

        // Применяем стиль в зависимости от типа элемента
        switch element.type {
        case .text:
            attributes = fontAttributes(for: configuration.text)

        case .header(let level):
            switch level {
            case 1: attributes = fontAttributes(for: configuration.h1)
            case 2: attributes = fontAttributes(for: configuration.h2)
            case 3: attributes = fontAttributes(for: configuration.h3)
            case 4: attributes = fontAttributes(for: configuration.h4)
            case 5: attributes = fontAttributes(for: configuration.h5)
            case 6: attributes = fontAttributes(for: configuration.h6)
            default: attributes = fontAttributes(for: configuration.h1)
            }
            // Добавляем перенос строки после заголовка
            let result = NSMutableAttributedString()
            result.append(NSAttributedString(string: content, attributes: attributes))
            result.append(NSAttributedString(string: "\n"))
            return result

        case .bold:
            attributes = fontAttributes(for: configuration.bold)

        case .italic:
            attributes = fontAttributes(for: configuration.italic)

        case .code:
            attributes = fontAttributes(for: configuration.code)

        case .codeBlock:
            attributes = fontAttributes(for: configuration.codeBlock)

        case .link(let title, let url):
            attributes = fontAttributes(for: configuration.link)
            // Для ссылок можно добавить underline
            #if canImport(UIKit)
                attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
            #elseif canImport(AppKit)
                attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
            #endif

        case .image(let title, let url):
            // Для изображений возвращаем просто текст с описанием
            attributes = fontAttributes(for: configuration.text)
            return NSAttributedString(string: "🖼️ \(title)", attributes: attributes)

        case .unorderedList(let inlineElements):
            // Создаем attributed string с префиксом и контентом
            let prefix = "• "
            let prefixAttributes = fontAttributes(for: configuration.listPrefix)

            let result = NSMutableAttributedString()
            result.append(NSAttributedString(string: prefix, attributes: prefixAttributes))

            // Добавляем inline элементы контента
            for element in inlineElements {
                result.append(createAttributedString(for: element))
            }
            
            // Добавляем перенос строки после элемента списка
            result.append(NSAttributedString(string: "\n"))
            return result

        case .orderedList(let number, let inlineElements):
            // Создаем attributed string с префиксом и контентом
            let prefix = "\(number). "
            let prefixAttributes = fontAttributes(for: configuration.listPrefix)

            let result = NSMutableAttributedString()
            result.append(NSAttributedString(string: prefix, attributes: prefixAttributes))

            // Добавляем inline элементы контента
            for element in inlineElements {
                result.append(createAttributedString(for: element))
            }
            
            // Добавляем перенос строки после элемента списка
            result.append(NSAttributedString(string: "\n"))
            return result

        case .lineBreak:
            return NSAttributedString(string: "\n")

        case .paragraph:
            // Параграф теперь обрабатывается как контейнер для inline элементов
            // Возвращаем пустую строку, так как inline элементы обрабатываются отдельно
            return NSAttributedString(string: "")

        case .table:
            // Таблицы пока не реализованы - возвращаем как обычный текст
            attributes = fontAttributes(for: configuration.text)
        }

        return NSAttributedString(string: content, attributes: attributes)
    }
}
