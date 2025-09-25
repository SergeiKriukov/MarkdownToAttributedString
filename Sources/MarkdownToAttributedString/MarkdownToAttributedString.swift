import Foundation

/// Основной класс для конвертации Markdown в NSAttributedString
public class MarkdownToAttributedString {

    private let parser: MarkdownParser
    private let converter: AttributedStringConverter

    /// Инициализирует конвертер с конфигурацией по умолчанию
    public init() {
        self.parser = MarkdownParser()
        self.converter = AttributedStringConverter()
    }

    /// Инициализирует конвертер с пользовательской конфигурацией
    /// - Parameter configuration: Конфигурация стилей для различных элементов Markdown
    public init(configuration: MarkdownConfiguration) {
        self.parser = MarkdownParser()
        self.converter = AttributedStringConverter(configuration: configuration)
    }

    /// Конвертирует Markdown строку в NSAttributedString
    /// - Parameter markdown: Строка с Markdown разметкой
    /// - Returns: NSAttributedString с форматированием
    public func convert(_ markdown: String) -> NSAttributedString {
        return converter.convert(markdown)
    }

    /// Парсит Markdown строку в массив элементов (для продвинутого использования)
    /// - Parameter markdown: Строка с Markdown разметкой
    /// - Returns: Массив Markdown элементов
    public func parse(_ markdown: String) -> [MarkdownElement] {
        return parser.parse(markdown)
    }

    /// Конвертирует массив Markdown элементов в NSAttributedString
    /// - Parameter elements: Массив Markdown элементов
    /// - Returns: NSAttributedString с форматированием
    public func convert(_ elements: [MarkdownElement]) -> NSAttributedString {
        return converter.convert(elements)
    }
}

/// Удобные методы расширения для String
public extension String {

    /// Конвертирует строку с Markdown в NSAttributedString
    /// - Parameter configuration: Конфигурация стилей (опционально)
    /// - Returns: NSAttributedString с форматированием
    func toAttributedString(configuration: MarkdownConfiguration = .init()) -> NSAttributedString {
        let converter = MarkdownToAttributedString(configuration: configuration)
        return converter.convert(self)
    }
}
