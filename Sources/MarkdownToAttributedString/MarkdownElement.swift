import Foundation

/// Перечисление типов Markdown элементов
public enum MarkdownElementType: Equatable {
    case text
    case header(level: Int)
    case bold
    case italic
    case code
    case codeBlock
    case link(title: String, url: String)
    case image(title: String, url: String)
    case unorderedList
    case orderedList(number: Int)
    case lineBreak
    case paragraph
    case table(headers: [String], rows: [[String]])
}

/// Модель Markdown элемента
public struct MarkdownElement {
    public let type: MarkdownElementType
    public let content: String
    public let range: Range<String.Index>?

    public init(type: MarkdownElementType, content: String, range: Range<String.Index>? = nil) {
        self.type = type
        self.content = content
        self.range = range
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
        listPrefix: MarkdownStyle = .init()
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
