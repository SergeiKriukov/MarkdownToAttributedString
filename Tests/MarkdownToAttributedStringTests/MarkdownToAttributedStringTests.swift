import XCTest
@testable import MarkdownToAttributedString

final class MarkdownToAttributedStringTests: XCTestCase {

    func testParseHeaders() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("# Header 1\n## Header 2\n### Header 3")

        XCTAssertEqual(elements.count, 3)

        XCTAssertEqual(elements[0].type, .header(level: 1))
        XCTAssertEqual(elements[0].content, "Header 1")

        XCTAssertEqual(elements[1].type, .header(level: 2))
        XCTAssertEqual(elements[1].content, "Header 2")

        XCTAssertEqual(elements[2].type, .header(level: 3))
        XCTAssertEqual(elements[2].content, "Header 3")
    }

    func testParseBoldText() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("This is **bold** text")

        XCTAssertEqual(elements.count, 3)

        XCTAssertEqual(elements[0].type, .text)
        XCTAssertEqual(elements[0].content, "This is ")

        XCTAssertEqual(elements[1].type, .bold)
        XCTAssertEqual(elements[1].content, "bold")

        XCTAssertEqual(elements[2].type, .text)
        XCTAssertEqual(elements[2].content, " text")
    }

    func testParseItalicText() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("This is *italic* text")

        XCTAssertEqual(elements.count, 3)

        XCTAssertEqual(elements[0].type, .text)
        XCTAssertEqual(elements[0].content, "This is ")

        XCTAssertEqual(elements[1].type, .italic)
        XCTAssertEqual(elements[1].content, "italic")

        XCTAssertEqual(elements[2].type, .text)
        XCTAssertEqual(elements[2].content, " text")
    }

    func testParseUnorderedList() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("- Item 1\n- Item 2\n- Item 3")

        XCTAssertEqual(elements.count, 3)

        for element in elements {
            XCTAssertEqual(element.type, .unorderedList)
        }

        XCTAssertEqual(elements[0].content, "Item 1")
        XCTAssertEqual(elements[1].content, "Item 2")
        XCTAssertEqual(elements[2].content, "Item 3")
    }

    func testParseOrderedList() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("1. Item 1\n2. Item 2\n3. Item 3")

        XCTAssertEqual(elements.count, 3)

        XCTAssertEqual(elements[0].type, .orderedList(number: 1))
        XCTAssertEqual(elements[0].content, "Item 1")

        XCTAssertEqual(elements[1].type, .orderedList(number: 2))
        XCTAssertEqual(elements[1].content, "Item 2")

        XCTAssertEqual(elements[2].type, .orderedList(number: 3))
        XCTAssertEqual(elements[2].content, "Item 3")
    }

    func testParseInlineCode() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("Use `print()` function")

        XCTAssertEqual(elements.count, 3)

        XCTAssertEqual(elements[0].type, .text)
        XCTAssertEqual(elements[0].content, "Use ")

        XCTAssertEqual(elements[1].type, .code)
        XCTAssertEqual(elements[1].content, "print()")

        XCTAssertEqual(elements[2].type, .text)
        XCTAssertEqual(elements[2].content, " function")
    }

    func testParseLink() throws {
        let parser = MarkdownParser()

        let elements = parser.parse("Check [Google](https://google.com)")

        XCTAssertEqual(elements.count, 2)

        XCTAssertEqual(elements[0].type, .text)
        XCTAssertEqual(elements[0].content, "Check ")

        XCTAssertEqual(elements[1].type, .link(title: "Google", url: "https://google.com"))
        XCTAssertEqual(elements[1].content, "Google")
    }

    func testConvertToAttributedString() throws {
        let converter = MarkdownToAttributedString()

        let markdown = "# Hello World\nThis is **bold** and *italic* text"
        let attributedString = converter.convert(markdown)

        XCTAssertNotNil(attributedString)
        XCTAssertGreaterThan(attributedString.length, 0)
    }

    func testStringExtension() throws {
        let markdown = "# Test Header\nNormal text"
        let attributedString = markdown.toAttributedString()

        XCTAssertNotNil(attributedString)
        XCTAssertGreaterThan(attributedString.length, 0)
    }

    func testCustomConfiguration() throws {
        let config = MarkdownConfiguration(
            text: .init(fontSize: 14),
            h1: .init(fontSize: 28, fontWeight: .bold)
        )

        let converter = MarkdownToAttributedString(configuration: config)
        let attributedString = converter.convert("# Header\nText")

        XCTAssertNotNil(attributedString)
    }
}
