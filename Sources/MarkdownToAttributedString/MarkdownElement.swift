import Foundation

/// Перечисление типов Markdown элементов
public enum MarkdownElementType {
    case text
    case header(level: Int)
    case bold
    case italic
    case code
    case codeBlock
    case link(title: String, url: String)
    case image(title: String, url: String)
    case unorderedList(content: [MarkdownElement])
    case orderedList(number: Int, content: [MarkdownElement])
    case lineBreak
    case paragraph
    case table(headers: [String], rows: [[String]])
}

/// Модель Markdown элемента
public struct MarkdownElement: Equatable {
    public let type: MarkdownElementType
    public let content: String
    public let range: Range<String.Index>?

    public init(type: MarkdownElementType, content: String, range: Range<String.Index>? = nil) {
        self.type = type
        self.content = content
        self.range = range
    }

    public static func == (lhs: MarkdownElement, rhs: MarkdownElement) -> Bool {
        // Для простоты сравниваем только type и content, игнорируя range
        return lhs.type == rhs.type && lhs.content == rhs.content
    }
}

extension MarkdownElementType: Equatable {
    public static func == (lhs: MarkdownElementType, rhs: MarkdownElementType) -> Bool {
        switch (lhs, rhs) {
        case (.text, .text):
            return true
        case (.header(let l), .header(let r)):
            return l == r
        case (.bold, .bold):
            return true
        case (.italic, .italic):
            return true
        case (.code, .code):
            return true
        case (.codeBlock, .codeBlock):
            return true
        case (.link(let lt, let lu), .link(let rt, let ru)):
            return lt == rt && lu == ru
        case (.image(let lt, let lu), .image(let rt, let ru)):
            return lt == rt && lu == ru
        case (.unorderedList(let lc), .unorderedList(let rc)):
            return lc == rc
        case (.orderedList(let ln, let lc), .orderedList(let rn, let rc)):
            return ln == rn && lc == rc
        case (.lineBreak, .lineBreak):
            return true
        case (.paragraph, .paragraph):
            return true
        case (.table(let lh, let lr), .table(let rh, let rr)):
            return lh == rh && lr == rr
        default:
            return false
        }
    }
}

/// Типы шрифтов для стилизации
public enum FontWeight {
    case regular
    case bold
    case semibold
    case light
}

/// Простая конфигурация стилей (без цветов для совместимости)
public struct MarkdownStyle {
    public let fontSize: CGFloat
    public let fontWeight: FontWeight
    public let isItalic: Bool

    public init(
        fontSize: CGFloat = 12,
        fontWeight: FontWeight = .regular,
        isItalic: Bool = false
    ) {
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.isItalic = isItalic
    }
}

/// Конфигурация всех стилей Markdown
public struct MarkdownConfiguration {
    public let text: MarkdownStyle
    public let h1: MarkdownStyle
    public let h2: MarkdownStyle
    public let h3: MarkdownStyle
    public let h4: MarkdownStyle
    public let h5: MarkdownStyle
    public let h6: MarkdownStyle
    public let bold: MarkdownStyle
    public let italic: MarkdownStyle
    public let code: MarkdownStyle
    public let codeBlock: MarkdownStyle
    public let link: MarkdownStyle
    public let listPrefix: MarkdownStyle

    public init(
        text: MarkdownStyle = .init(),
        h1: MarkdownStyle = .init(fontSize: 24, fontWeight: .bold),
        h2: MarkdownStyle = .init(fontSize: 18, fontWeight: .bold),
        h3: MarkdownStyle = .init(fontSize: 15, fontWeight: .bold),
        h4: MarkdownStyle = .init(fontSize: 13, fontWeight: .bold),
        h5: MarkdownStyle = .init(fontSize: 11, fontWeight: .bold),
        h6: MarkdownStyle = .init(fontSize: 10, fontWeight: .bold),
        bold: MarkdownStyle = .init(fontWeight: .bold),
        italic: MarkdownStyle = .init(isItalic: true),
        code: MarkdownStyle = .init(),
        codeBlock: MarkdownStyle = .init(),
        link: MarkdownStyle = .init(),
        listPrefix: MarkdownStyle = .init(fontWeight: .semibold)
    ) {
        self.text = text
        self.h1 = h1
        self.h2 = h2
        self.h3 = h3
        self.h4 = h4
        self.h5 = h5
        self.h6 = h6
        self.bold = bold
        self.italic = italic
        self.code = code
        self.codeBlock = codeBlock
        self.link = link
        self.listPrefix = listPrefix
    }
}
