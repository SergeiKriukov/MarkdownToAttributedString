import XCTest
@testable import MarkdownToAttributedString

final class MarkdownToAttributedStringTests: XCTestCase {
    
    // MARK: - Basic Conversion Tests
    
    func testBasicConversion() {
        let markdown = "# Test Header\nThis is **bold** and *italic* text."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertFalse(attributedString.string.isEmpty)
        XCTAssertTrue(attributedString.string.contains("Test Header"))
        XCTAssertTrue(attributedString.string.contains("bold"))
        XCTAssertTrue(attributedString.string.contains("italic"))
    }
    
    // func testEmptyMarkdown() {
    //     let markdown = ""
    //     let attributedString = markdown.toAttributedString()
    //     
    //     // Пустая строка может возвращать пустой результат или результат с минимальным содержимым
    //     XCTAssertTrue(attributedString.string.isEmpty || attributedString.length == 0)
    // }
    
    func testPlainText() {
        let markdown = "This is plain text without any formatting."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertEqual(attributedString.string, markdown)
    }
    
    // MARK: - Header Tests
    
    func testHeaders() {
        let markdown = """
        # H1 Header
        ## H2 Header
        ### H3 Header
        #### H4 Header
        ##### H5 Header
        ###### H6 Header
        """
        
        let attributedString = markdown.toAttributedString()
        let text = attributedString.string
        
        XCTAssertTrue(text.contains("H1 Header"))
        XCTAssertTrue(text.contains("H2 Header"))
        XCTAssertTrue(text.contains("H3 Header"))
        XCTAssertTrue(text.contains("H4 Header"))
        XCTAssertTrue(text.contains("H5 Header"))
        XCTAssertTrue(text.contains("H6 Header"))
    }
    
    // MARK: - Text Formatting Tests
    
    func testBoldText() {
        let markdown = "This is **bold** text."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("bold"))
    }
    
    func testItalicText() {
        let markdown = "This is *italic* text."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("italic"))
    }
    
    func testBoldAndItalic() {
        let markdown = "This is ***bold and italic*** text."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("bold and italic"))
    }
    
    // MARK: - Code Tests
    
    func testInlineCode() {
        let markdown = "This is `inline code` text."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("inline code"))
    }
    
    func testCodeBlock() {
        let markdown = """
        ```
        This is a code block
        with multiple lines
        ```
        """
        
        let attributedString = markdown.toAttributedString()
        let text = attributedString.string
        
        XCTAssertTrue(text.contains("This is a code block"))
        XCTAssertTrue(text.contains("with multiple lines"))
    }
    
    // MARK: - List Tests
    
    func testUnorderedList() {
        let markdown = """
        - Item 1
        - Item 2
        - Item 3
        """
        
        let attributedString = markdown.toAttributedString()
        let text = attributedString.string
        
        XCTAssertTrue(text.contains("Item 1"))
        XCTAssertTrue(text.contains("Item 2"))
        XCTAssertTrue(text.contains("Item 3"))
    }
    
    func testOrderedList() {
        let markdown = """
        1. First item
        2. Second item
        3. Third item
        """
        
        let attributedString = markdown.toAttributedString()
        let text = attributedString.string
        
        XCTAssertTrue(text.contains("First item"))
        XCTAssertTrue(text.contains("Second item"))
        XCTAssertTrue(text.contains("Third item"))
    }
    
    // MARK: - Link Tests
    
    func testLinks() {
        let markdown = "Visit [Apple](https://apple.com) for more info."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("Apple"))
    }
    
    func testImages() {
        let markdown = "![Alt text](https://example.com/image.png)"
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("Alt text"))
    }
    
    // MARK: - Configuration Tests
    
    func testCustomConfiguration() {
        let config = MarkdownConfiguration(
            h1: .init(fontSize: 32, fontWeight: .bold),
            bold: .init(fontWeight: .bold)
        )
        
        let markdown = "# Header\n**Bold** text"
        let attributedString = markdown.toAttributedString(configuration: config)
        
        XCTAssertFalse(attributedString.string.isEmpty)
        XCTAssertTrue(attributedString.string.contains("Header"))
        XCTAssertTrue(attributedString.string.contains("Bold"))
    }
    
    func testDefaultConfiguration() {
        let markdown = "# Header\n**Bold** text"
        let attributedString = markdown.toAttributedString()
        
        XCTAssertFalse(attributedString.string.isEmpty)
    }
    
    // MARK: - Parser Tests
    
    func testParser() {
        let parser = MarkdownParser()
        let markdown = "# Header\n**Bold** text"
        let elements = parser.parse(markdown)
        
        XCTAssertFalse(elements.isEmpty)
    }
    
    // func testParserWithEmptyString() {
    //     let parser = MarkdownParser()
    //     let elements = parser.parse("")
    //     
    //     // Парсер может возвращать пустой массив или массив с минимальными элементами
    //     XCTAssertTrue(elements.isEmpty || elements.count == 0)
    // }
    
    // MARK: - Converter Tests
    
    func testConverter() {
        let converter = AttributedStringConverter()
        let markdown = "# Header\n**Bold** text"
        
        let parser = MarkdownParser()
        let elements = parser.parse(markdown)
        let attributedString = converter.convert(elements)
        
        XCTAssertFalse(attributedString.string.isEmpty)
    }
    
    func testConverterWithEmptyElements() {
        let converter = AttributedStringConverter()
        let attributedString = converter.convert([])
        
        XCTAssertTrue(attributedString.string.isEmpty)
    }
    
    // MARK: - Complex Markdown Tests
    
    func testComplexMarkdown() {
        let markdown = """
        # Main Title
        
        This is a **bold** statement and this is *italic* text.
        
        ## Features
        - Easy to use
        - Highly customizable
        - Cross-platform support
        
        ### Code Example
        ```swift
        let attributedString = markdown.toAttributedString()
        ```
        
        Visit [GitHub](https://github.com) for more info.
        """
        
        let attributedString = markdown.toAttributedString()
        let text = attributedString.string
        
        XCTAssertTrue(text.contains("Main Title"))
        XCTAssertTrue(text.contains("bold"))
        XCTAssertTrue(text.contains("italic"))
        XCTAssertTrue(text.contains("Features"))
        XCTAssertTrue(text.contains("Easy to use"))
        XCTAssertTrue(text.contains("Code Example"))
        XCTAssertTrue(text.contains("GitHub"))
    }
    
    // MARK: - Edge Cases
    
    func testMalformedMarkdown() {
        let markdown = "**Bold without closing** and *italic without closing"
        let attributedString = markdown.toAttributedString()
        
        // Should not crash and should return some result
        XCTAssertFalse(attributedString.string.isEmpty)
    }
    
    func testNestedFormatting() {
        let markdown = "This is **bold with *italic* inside** text."
        let attributedString = markdown.toAttributedString()
        
        XCTAssertTrue(attributedString.string.contains("bold with"))
        XCTAssertTrue(attributedString.string.contains("italic"))
        XCTAssertTrue(attributedString.string.contains("inside"))
    }
    
    func testMultipleParagraphs() {
        let markdown = """
        First paragraph.
        
        Second paragraph.
        
        Third paragraph.
        """
        
        let attributedString = markdown.toAttributedString()
        let text = attributedString.string
        
        XCTAssertTrue(text.contains("First paragraph"))
        XCTAssertTrue(text.contains("Second paragraph"))
        XCTAssertTrue(text.contains("Third paragraph"))
    }
    
    // MARK: - Performance Tests
    
    func testPerformance() {
        let markdown = """
        # Performance Test
        
        This is a **performance** test with *multiple* elements.
        
        ## Features
        - Item 1
        - Item 2
        - Item 3
        
        ```swift
        let code = "example"
        ```
        
        Visit [Link](https://example.com) for more info.
        """
        
        measure {
            for _ in 0..<100 {
                _ = markdown.toAttributedString()
            }
        }
    }
    
    // MARK: - Platform-Specific Tests
    
    #if canImport(UIKit)
    func testUIKitIntegration() {
        let markdown = "# iOS Test\n**Bold** text"
        let attributedString = markdown.toAttributedString()
        
        XCTAssertFalse(attributedString.string.isEmpty)
    }
    #endif
    
    #if canImport(AppKit)
    func testAppKitIntegration() {
        let markdown = "# macOS Test\n**Bold** text"
        let attributedString = markdown.toAttributedString()
        
        XCTAssertFalse(attributedString.string.isEmpty)
    }
    #endif
}