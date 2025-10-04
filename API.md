# API Documentation

This document provides detailed API documentation for MarkdownToAttributedString.

## Core Classes

### MarkdownToAttributedString

The main converter class that handles the conversion from Markdown to NSAttributedString.

```swift
public class MarkdownToAttributedString {
    public init(configuration: MarkdownConfiguration = .default)
    public func convert(_ markdown: String) -> NSAttributedString
}
```

#### Methods

- `init(configuration:)` - Initialize with custom configuration
- `convert(_:)` - Convert Markdown string to NSAttributedString

### MarkdownParser

Parses Markdown text into structured elements.

```swift
public class MarkdownParser {
    public init()
    public func parse(_ markdown: String) -> [MarkdownElement]
}
```

#### Methods

- `init()` - Initialize parser
- `parse(_:)` - Parse Markdown string into elements

### AttributedStringConverter

Converts parsed Markdown elements to NSAttributedString.

```swift
public class AttributedStringConverter {
    public init(configuration: MarkdownConfiguration = .default)
    public func convert(_ elements: [MarkdownElement]) -> NSAttributedString
}
```

#### Methods

- `init(configuration:)` - Initialize with custom configuration
- `convert(_:)` - Convert elements to NSAttributedString

## Configuration

### MarkdownConfiguration

Configuration class for customizing the appearance of converted text.

```swift
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
    public let strikethrough: MarkdownStyle
    public let code: MarkdownStyle
    public let codeBlock: MarkdownStyle
    public let link: MarkdownStyle
    public let listPrefix: MarkdownStyle
    public let blockquote: MarkdownStyle

    public init(
        text: MarkdownStyle = .init(),
        h1: MarkdownStyle = .init(fontSize: 24, fontWeight: .bold),
        h2: MarkdownStyle = .init(fontSize: 20, fontWeight: .semibold),
        h3: MarkdownStyle = .init(fontSize: 18, fontWeight: .medium),
        h4: MarkdownStyle = .init(fontSize: 16, fontWeight: .medium),
        h5: MarkdownStyle = .init(fontSize: 14, fontWeight: .medium),
        h6: MarkdownStyle = .init(fontSize: 12, fontWeight: .medium),
        bold: MarkdownStyle = .init(fontWeight: .bold),
        italic: MarkdownStyle = .init(isItalic: true),
        strikethrough: MarkdownStyle = .init(),
        code: MarkdownStyle = .init(),
        codeBlock: MarkdownStyle = .init(),
        link: MarkdownStyle = .init(),
        listPrefix: MarkdownStyle = .init(fontWeight: .semibold),
        blockquote: MarkdownStyle = .init()
    )
}
```

### MarkdownStyle

Style configuration for individual Markdown elements.

```swift
public struct MarkdownStyle {
    public let fontSize: CGFloat
    public let fontWeight: FontWeight
    public let isItalic: Bool
    public let foregroundColor: Color?
    
    public init(
        fontSize: CGFloat = 16,
        fontWeight: FontWeight = .regular,
        isItalic: Bool = false,
        foregroundColor: Color? = nil
    )
}
```

#### Properties

- `fontSize` - Font size in points
- `fontWeight` - Font weight (regular, bold, semibold, light)
- `isItalic` - Whether text should be italic
- `foregroundColor` - Text color (platform-specific)

### FontWeight

Enumeration of available font weights.

```swift
public enum FontWeight {
    case regular
    case bold
    case semibold
    case light
}
```

## Data Models

### MarkdownElement

Represents a parsed Markdown element.

```swift
public struct MarkdownElement: Equatable {
    public let type: MarkdownElementType
    public let content: String
    public let range: Range<String.Index>?
    
    public init(
        type: MarkdownElementType,
        content: String,
        range: Range<String.Index>? = nil
    )
}
```

#### Properties

- `type` - The type of Markdown element
- `content` - The text content
- `range` - The range in the original string

### MarkdownElementType

Enumeration of supported Markdown element types.

```swift
public enum MarkdownElementType: Equatable {
    case text
    case header(level: Int)
    case bold
    case italic
    case strikethrough
    case code
    case codeBlock
    case link(title: String, url: String)
    case image(title: String, url: String)
    case unorderedList(content: [MarkdownElement])
    case orderedList(number: Int, content: [MarkdownElement])
    case lineBreak
    case paragraph
    case blockquote(content: [MarkdownElement])
    case table(headers: [String], rows: [[String]])
}
```

#### Cases

- `text` - Plain text
- `header(level:)` - Header with level (1-6)
- `bold` - Bold text
- `italic` - Italic text
- `strikethrough` - Strikethrough text
- `code` - Inline code
- `codeBlock` - Code block
- `link(title:url:)` - Link with title and URL
- `image(title:url:)` - Image with title and URL
- `unorderedList(content:)` - Unordered list with content
- `orderedList(number:content:)` - Ordered list with number and content
- `lineBreak` - Line break
- `paragraph` - Paragraph
- `blockquote(content:)` - Blockquote with content
- `table(headers:rows:)` - Table with headers and rows

## Extensions

### String Extension

Convenience extension for String to convert Markdown directly.

```swift
extension String {
    public func toAttributedString(
        configuration: MarkdownConfiguration = .default
    ) -> NSAttributedString
}
```

#### Methods

- `toAttributedString(configuration:)` - Convert Markdown string to NSAttributedString

## Platform Support

### iOS

```swift
#if canImport(UIKit)
import UIKit

extension MarkdownStyle {
    public var uiColor: UIColor? {
        return foregroundColor as? UIColor
    }
}
#endif
```

### macOS

```swift
#if canImport(AppKit)
import AppKit

extension MarkdownStyle {
    public var nsColor: NSColor? {
        return foregroundColor as? NSColor
    }
}
#endif
```

## Error Handling

### Conversion Errors

The library handles various error conditions gracefully:

- **Invalid Markdown**: Malformed Markdown is converted to plain text
- **Missing Elements**: Unsupported elements are treated as plain text
- **Configuration Errors**: Invalid configurations fall back to defaults

### Best Practices

1. **Always check for empty results**:
   ```swift
   let attributedString = markdown.toAttributedString()
   guard attributedString.length > 0 else {
       // Handle empty result
       return
   }
   ```

2. **Use appropriate configurations**:
   ```swift
   let config = MarkdownConfiguration(
       h1: .init(fontSize: 24, fontWeight: .bold),
       bold: .init(fontWeight: .bold)
   )
   ```

3. **Handle platform differences**:
   ```swift
   #if canImport(UIKit)
   // iOS-specific code
   #elseif canImport(AppKit)
   // macOS-specific code
   #endif
   ```

## Performance Considerations

### Memory Usage

- NSAttributedString objects can be memory-intensive
- Consider caching for frequently used content
- Use lazy loading for large documents

### Parsing Performance

- Parsing is optimized for common Markdown patterns
- Complex nested structures may impact performance
- Consider background processing for large documents

### Best Practices

1. **Cache results**:
   ```swift
   class MarkdownCache {
       private var cache: [String: NSAttributedString] = [:]
       
       func attributedString(for markdown: String) -> NSAttributedString {
           if let cached = cache[markdown] {
               return cached
           }
           
           let result = markdown.toAttributedString()
           cache[markdown] = result
           return result
       }
   }
   ```

2. **Background processing**:
   ```swift
   DispatchQueue.global(qos: .userInitiated).async {
       let attributedString = markdown.toAttributedString()
       
       DispatchQueue.main.async {
           // Update UI
       }
   }
   }
   ```

3. **Incremental updates**:
   ```swift
   func updateMarkdown(_ newMarkdown: String) {
       // Only convert if content changed
       if newMarkdown != currentMarkdown {
           currentMarkdown = newMarkdown
           attributedString = newMarkdown.toAttributedString()
       }
   }
   ```

## Testing

### Unit Tests

```swift
import XCTest
@testable import MarkdownToAttributedString

class MarkdownToAttributedStringTests: XCTestCase {
    func testBasicConversion() {
        let markdown = "# Test\n**Bold** text"
        let attributedString = markdown.toAttributedString()
        
        XCTAssertFalse(attributedString.string.isEmpty)
        XCTAssertTrue(attributedString.string.contains("Test"))
    }
    
    func testCustomConfiguration() {
        let config = MarkdownConfiguration(
            h1: .init(fontSize: 32, fontWeight: .bold)
        )
        
        let markdown = "# Header"
        let attributedString = markdown.toAttributedString(configuration: config)
        
        XCTAssertFalse(attributedString.string.isEmpty)
    }
}
```

### Integration Tests

```swift
func testFullWorkflow() {
    let markdown = """
    # Title
    **Bold** and *italic* text
    - List item 1
    - List item 2
    """
    
    let parser = MarkdownParser()
    let elements = parser.parse(markdown)
    
    let converter = AttributedStringConverter()
    let attributedString = converter.convert(elements)
    
    XCTAssertFalse(attributedString.string.isEmpty)
    XCTAssertTrue(attributedString.string.contains("Title"))
}
```

This API documentation should help you understand and use all the features of MarkdownToAttributedString effectively.
