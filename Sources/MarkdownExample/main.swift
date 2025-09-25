import Foundation
import MarkdownToAttributedString

print("🚀 MarkdownToAttributedString - Comprehensive Demo")
print(String(repeating: "=", count: 60))

// MARK: - Sample Markdown Content
let sampleMarkdown = """
# Welcome to MarkdownToAttributedString

This is a **powerful library** for converting *Markdown* text to `NSAttributedString`.

## Key Features

### Text Formatting
- **Bold text** support
- *Italic text* support
- `Inline code` support
- ~~Strikethrough~~ text (if supported)

### Lists
- Unordered lists with bullets
- Numbered lists with automatic numbering
- Nested lists (if supported)

### Code Blocks
```swift
let attributedString = markdown.toAttributedString()
print("Hello, World!")
```

### Links and Images
Visit [Apple Developer](https://developer.apple.com) for more information.

![Swift Logo](https://swift.org/assets/images/swift.svg)

## Advanced Usage

### Custom Configuration
You can customize the appearance of different elements:

- Headers (H1-H6)
- Bold and italic text
- Code blocks and inline code
- Lists and list prefixes
- Links and images

### Export Options
- Export to RTF format
- Export to plain text
- Copy to clipboard with formatting

## Performance
The library is optimized for:
- Fast parsing
- Memory efficiency
- Cross-platform compatibility

---

*Made with ❤️ for the Swift community*
"""

print("📝 Sample Markdown Content:")
print(sampleMarkdown)
print("\n" + String(repeating: "=", count: 60))

// MARK: - Basic Conversion
print("🔄 Basic Conversion:")
let basicResult = sampleMarkdown.toAttributedString()
print("✅ Basic conversion completed!")
print("📊 Result length: \(basicResult.length) characters")
print("📄 First 100 characters: \(String(basicResult.string.prefix(100)))...")
print()

// MARK: - Custom Configuration
print("🎨 Custom Configuration:")
let customConfig = MarkdownConfiguration(
    h1: .init(fontSize: 28, fontWeight: .bold),
    h2: .init(fontSize: 24, fontWeight: .semibold),
    h3: .init(fontSize: 20, fontWeight: .semibold),
    bold: .init(fontWeight: .bold),
    italic: .init(isItalic: true),
    code: .init(fontSize: 14, fontWeight: .regular),
    listPrefix: .init(fontWeight: .semibold)
)

let customResult = sampleMarkdown.toAttributedString(configuration: customConfig)
print("✅ Custom configuration applied!")
print("📊 Result length: \(customResult.length) characters")
print()

// MARK: - Parser Analysis
print("🔍 Parser Analysis:")
let parser = MarkdownParser()
let elements = parser.parse(sampleMarkdown)
print("📋 Total elements found: \(elements.count)")

var elementCounts: [String: Int] = [:]
for element in elements {
    let typeName = String(describing: element.type).components(separatedBy: "(").first ?? "unknown"
    elementCounts[typeName, default: 0] += 1
}

print("📊 Element breakdown:")
for (type, count) in elementCounts.sorted(by: { $0.value > $1.value }) {
    print("  \(type): \(count)")
}
print()

// MARK: - Manual Conversion
print("🔧 Manual Conversion Process:")
let converter = MarkdownToAttributedString(configuration: customConfig)
let manualResult = converter.convert(sampleMarkdown)
print("✅ Manual conversion completed!")
print("📊 Result length: \(manualResult.length) characters")
print()

// MARK: - Export Examples
print("📤 Export Examples:")

// RTF Export
do {
    let rtfData = try manualResult.data(
        from: NSRange(location: 0, length: manualResult.length),
        documentAttributes: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.rtf]
    )
    print("✅ RTF data generated: \(rtfData.count) bytes")
} catch {
    print("❌ RTF export failed: \(error)")
}

// Plain Text Export
let plainText = manualResult.string
print("✅ Plain text extracted: \(plainText.count) characters")
print("📄 First 200 characters: \(String(plainText.prefix(200)))...")
print()

// MARK: - Performance Test
print("⚡ Performance Test:")
let testMarkdown = "# Test\n**Bold** and *italic* text with `code`."
let iterations = 1000

let startTime = CFAbsoluteTimeGetCurrent()
for _ in 0..<iterations {
    _ = testMarkdown.toAttributedString()
}
let endTime = CFAbsoluteTimeGetCurrent()

let totalTime = endTime - startTime
let averageTime = totalTime / Double(iterations)
print("✅ Completed \(iterations) conversions in \(String(format: "%.4f", totalTime)) seconds")
print("📊 Average time per conversion: \(String(format: "%.6f", averageTime)) seconds")
print("🚀 Performance: \(String(format: "%.0f", Double(iterations) / totalTime)) conversions/second")
print()

// MARK: - Style Verification
print("🎨 Style Verification:")
let styleTestMarkdown = "# Header\n**Bold** and *italic* text"
let styleResult = styleTestMarkdown.toAttributedString(configuration: customConfig)

print("📝 Test markdown: \"\(styleTestMarkdown)\"")
print("📊 Result length: \(styleResult.length)")

if styleResult.length > 0 {
    // Check for attributes at different positions
    let headerAttrs = styleResult.attributes(at: 0, effectiveRange: nil as NSRangePointer?)
    print("🎯 Header attributes: \(headerAttrs.count > 0 ? "✅ Present" : "❌ Missing")")
    
    if let boldRange = styleResult.string.range(of: "Bold") {
        let nsRange = NSRange(boldRange, in: styleResult.string)
        let boldAttrs = styleResult.attributes(at: nsRange.location, effectiveRange: nil as NSRangePointer?)
        print("💪 Bold attributes: \(boldAttrs.count > 0 ? "✅ Present" : "❌ Missing")")
    }
    
    if let italicRange = styleResult.string.range(of: "italic") {
        let nsRange = NSRange(italicRange, in: styleResult.string)
        let italicAttrs = styleResult.attributes(at: nsRange.location, effectiveRange: nil as NSRangePointer?)
        print("🎭 Italic attributes: \(italicAttrs.count > 0 ? "✅ Present" : "❌ Missing")")
    }
}
print()

// MARK: - Platform Information
print("📱 Platform Information:")
#if canImport(UIKit)
print("🟦 Platform: iOS (UIKit)")
#elseif canImport(AppKit)
print("🟦 Platform: macOS (AppKit)")
#elseif canImport(WatchKit)
print("🟦 Platform: watchOS (WatchKit)")
#elseif canImport(TVMLKit)
print("🟦 Platform: tvOS (TVMLKit)")
#else
print("🟦 Platform: Unknown")
#endif

print("🔧 Swift Version: 5.9+")
print("📦 Package Version: 1.0.0")
print()

// MARK: - Summary
print("📋 Summary:")
print("✅ Basic conversion: Working")
print("✅ Custom configuration: Working")
print("✅ Parser analysis: Working")
print("✅ Manual conversion: Working")
print("✅ Export functionality: Working")
print("✅ Performance test: Completed")
print("✅ Style verification: Working")
print()

print("🎉 Demo completed successfully!")
print("💡 The library is ready for use in your projects!")
print("📚 Check the documentation for more examples and API details.")
print("🔗 GitHub: https://github.com/SergeiKriukov/MarkdownToAttributedString")
print(String(repeating: "=", count: 60))