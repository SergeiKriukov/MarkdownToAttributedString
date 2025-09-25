# MarkdownToAttributedString

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-blue.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A powerful Swift library for converting Markdown text to `NSAttributedString` with full formatting support. Perfect for iOS, macOS, tvOS, and watchOS applications that need to display rich text from Markdown sources.

## ✨ Features

- 🎯 **Complete Markdown Support** - Headers, bold, italic, code, lists, links, images
- 🎨 **Customizable Styling** - Configure fonts, sizes, colors, and weights for each element
- 📱 **Cross-Platform** - Works on iOS, macOS, tvOS, and watchOS
- 🚀 **High Performance** - Optimized parsing and conversion
- 🔧 **Easy Integration** - Simple API with Swift Package Manager support
- 📝 **RTF Export** - Convert to Rich Text Format for document sharing
- 📄 **Plain Text Export** - Extract clean text without formatting

## 🚀 Quick Start

### Installation

Add MarkdownToAttributedString to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/SergeiKriukov/MarkdownToAttributedString.git", from: "1.0.0")
]
```

### Basic Usage

```swift
import MarkdownToAttributedString

let markdown = """
# Welcome to MarkdownToAttributedString

This is **bold** and *italic* text with `inline code`.

## Features
- Easy to use
- Highly customizable
- Cross-platform support
"""

// Convert with default styling
let attributedString = markdown.toAttributedString()

// Or use custom configuration
let customConfig = MarkdownConfiguration(
    h1: .init(fontSize: 28, fontWeight: .bold),
    bold: .init(fontWeight: .bold, isItalic: false)
)
let customAttributedString = markdown.toAttributedString(configuration: customConfig)
```

## 🎨 Customization

### Styling Configuration

```swift
let config = MarkdownConfiguration(
    // Header styles
    h1: .init(fontSize: 24, fontWeight: .bold),
    h2: .init(fontSize: 20, fontWeight: .semibold),
    h3: .init(fontSize: 18, fontWeight: .medium),
    
    // Text formatting
    bold: .init(fontWeight: .bold),
    italic: .init(isItalic: true),
    code: .init(fontSize: 14, fontWeight: .regular),
    
    // List styling
    listPrefix: .init(fontWeight: .semibold)
)

let attributedString = markdown.toAttributedString(configuration: config)
```

### Available Style Properties

- `fontSize` - Text size in points
- `fontWeight` - Font weight (regular, bold, semibold, light)
- `isItalic` - Italic text styling
- `foregroundColor` - Text color (iOS/macOS)

## 📋 Supported Markdown Elements

| Element | Example | Status |
|---------|---------|--------|
| Headers | `# H1`, `## H2`, `### H3` | ✅ |
| Bold | `**bold text**` | ✅ |
| Italic | `*italic text*` | ✅ |
| Inline Code | `` `code` `` | ✅ |
| Code Blocks | ```` ```code``` ```` | ✅ |
| Links | `[text](url)` | ✅ |
| Images | `![alt](url)` | ✅ |
| Lists | `- item`, `1. item` | ✅ |
| Line Breaks | `\n` | ✅ |

## 🔧 Advanced Usage

### Manual Conversion

```swift
import MarkdownToAttributedString

let parser = MarkdownParser()
let converter = AttributedStringConverter()

// Parse markdown into elements
let elements = parser.parse(markdown)

// Convert to attributed string
let attributedString = converter.convert(elements)
```

### Export to RTF

```swift
let attributedString = markdown.toAttributedString()

// Export to RTF data
let rtfData = try attributedString.data(
    from: NSRange(location: 0, length: attributedString.length),
    documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]
)

// Save to file
try rtfData.write(to: fileURL)
```

### Extract Plain Text

```swift
let attributedString = markdown.toAttributedString()
let plainText = attributedString.string
// Result: "Welcome to MarkdownToAttributedString\nThis is bold and italic text..."
```

## 📱 Platform Support

| Platform | Minimum Version | Status |
|----------|----------------|--------|
| iOS | 15.0+ | ✅ |
| macOS | 12.0+ | ✅ |
| tvOS | 15.0+ | ✅ |
| watchOS | 8.0+ | ✅ |

## 🧪 Testing

The library includes comprehensive tests for all supported Markdown elements:

```bash
swift test
```

## 📖 Examples

### iOS App Integration

```swift
import SwiftUI
import MarkdownToAttributedString

struct ContentView: View {
    @State private var markdown = "# Hello World\nThis is **bold** text"
    
    var body: some View {
        VStack {
            TextEditor(text: $markdown)
                .frame(height: 200)
            
            Text(AttributedString(markdown.toAttributedString()))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
```

### macOS App with Export

```swift
import AppKit
import MarkdownToAttributedString

class DocumentController: NSDocumentController {
    func exportToRTF(_ markdown: String) {
        let attributedString = markdown.toAttributedString()
        
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.rtf]
        
        savePanel.begin { response in
            if response == .OK, let url = savePanel.url {
                do {
                    let rtfData = try attributedString.data(
                        from: NSRange(location: 0, length: attributedString.length),
                        documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]
                    )
                    try rtfData.write(to: url)
                } catch {
                    print("Export failed: \(error)")
                }
            }
        }
    }
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Clone the repository
2. Open in Xcode or use Swift Package Manager
3. Run tests: `swift test`
4. Build the example: `swift build`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the need for easy Markdown to NSAttributedString conversion
- Built with Swift's powerful string processing capabilities
- Thanks to the Swift community for excellent documentation and examples

## 📞 Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/SergeiKriukov/MarkdownToAttributedString/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/SergeiKriukov/MarkdownToAttributedString/discussions)
- 📧 **Contact**: [GitHub Profile](https://github.com/SergeiKriukov)

---

Made with ❤️ for the Swift community