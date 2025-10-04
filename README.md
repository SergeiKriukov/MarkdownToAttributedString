# MarkdownToAttributedString

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-blue.svg)](https://developer.apple.com/swift/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A powerful Swift library for converting Markdown text to `NSAttributedString` with full formatting support. Perfect for iOS, macOS, tvOS, and watchOS applications that need to display rich text from Markdown sources.

<img width="826" height="804" alt="image" src="https://github.com/user-attachments/assets/ea839987-82b4-443c-a431-fbf7117e235f" />


## ✨ Features

- 🎯 **Complete Markdown Support** - Headers, bold, italic, strikethrough, code, lists, links, images, blockquotes
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
You can also use ~~strikethrough~~ formatting.

## Features
- Easy to use
- Highly customizable
- Cross-platform support

> This is a blockquote with **bold** text inside.
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
    strikethrough: .init(),
    code: .init(fontSize: 14, fontWeight: .regular),

    // List and blockquote styling
    listPrefix: .init(fontWeight: .semibold),
    blockquote: .init()
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
| Strikethrough | `~~strikethrough~~` | ✅ |
| Inline Code | `` `code` `` | ✅ |
| Code Blocks | ```` ```code``` ```` | ✅ |
| Links | `[text](url)` | ✅ |
| Images | `![alt](url)` | ✅ |
| Lists | `- item`, `1. item` | ✅ |
| Blockquotes | `> quote text` | ✅ |
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

## 🗺️ **Roadmap & Future Features**

### 🚀 **Version 2.1.0 - Typography & Accessibility (Q2 2025)**

#### ✨ Dynamic Type Support
Автоматическая адаптация размера шрифта под системные настройки пользователя.

```swift
// Будущий API
let config = MarkdownConfiguration.dynamicType(
    h1: .init(fontWeight: .bold),
    body: .init(fontSize: .body) // .largeTitle, .title1, .body, .caption etc.
)

let attributedString = markdown.toAttributedString(
    configuration: config,
    traitCollection: UITraitCollection(preferredContentSizeCategory: .extraLarge)
)
```

**Реализация:**
- Расширение `MarkdownStyle` с `FontSize` enum
- Добавление метода `dynamicType()` в `MarkdownConfiguration`
- Интеграция с `UITraitCollection` для автоматической адаптации

#### 🎯 Custom Bullets for Lists
Возможность использовать кастомные маркеры вместо стандартных.

```swift
let config = MarkdownConfiguration(
    listPrefix: .init(
        unorderedSymbols: ["🍎", "🍌", "🍇"], // Для разных уровней вложенности
        orderedStyle: .circledNumbers // .numbers, .letters, .roman, .circledNumbers
    )
)

// Markdown: - Item 1\n  - Item 2\n    - Item 3
// Результат: 🍎 Item 1\n  🍌 Item 2\n    🍇 Item 3
```

**Реализация:**
- Добавление `unorderedSymbols` и `orderedStyle` в `MarkdownConfiguration`
- Расширение `MarkdownElementType.unorderedList` с уровнем вложенности
- Логика выбора символа по уровню в `AttributedStringConverter`

### 🔮 **Version 2.2.0 - Advanced Markdown (Q3 2025)**

#### 📝 Front Matter / YAML Support
Поддержка метаданных в начале Markdown файлов.

```yaml
---
title: "My Document"
author: "John Doe"
date: "2025-10-04"
tags: ["markdown", "swift"]
---

# Document Content
This is the actual content...
```

```swift
if let frontMatter = markdown.frontMatter {
    print("Title: \(frontMatter["title"] ?? "")")
    print("Author: \(frontMatter["author"] ?? "")")
}

// Или получение чистого контента без метаданных
let cleanContent = markdown.contentWithoutFrontMatter
```

**Реализация:**
- Класс `FrontMatterParser` для парсинга YAML
- Расширение `String` с методами `frontMatter` и `contentWithoutFrontMatter`
- Поддержка различных форматов разделителей (---, +++)

#### 🔗 Referenced Links & Images
Расширенный синтаксис для ссылок и изображений.

```markdown
This is a [referenced link][1] and ![referenced image][2].

[1]: https://example.com "Optional title"
[2]: /path/to/image.png "Alt text"
```

**Реализация:**
- Парсинг ссылок в конце документа
- Создание словаря соответствий
- Замена referenced синтаксиса на стандартный

#### 📏 Line & Paragraph Spacing
Точный контроль типографики.

```swift
let config = MarkdownConfiguration(
    h1: .init(lineSpacing: 8, paragraphSpacing: 16),
    body: .init(lineSpacing: 4, paragraphSpacing: 8),
    blockquote: .init(lineSpacing: 2, paragraphSpacing: 12)
)
```

**Реализация:**
- Добавление `lineSpacing` и `paragraphSpacing` в `MarkdownStyle`
- Применение `NSMutableParagraphStyle` в `AttributedStringConverter`

### 🌟 **Version 2.3.0 - Rich Content (Q4 2025)**

#### 🖼️ Bundle Images Support
Поддержка изображений из app bundle.

```markdown
![App Icon](<AppIcon>)
![Custom Asset](<my-custom-image>)
```

```swift
let config = MarkdownConfiguration(
    image: .init(
        bundle: Bundle.main,
        placeholder: "🖼️" // Для изображений, которые не найдены
    )
)
```

**Реализация:**
- Расширение `MarkdownElementType.image` с bundle поддержкой
- Использование `NSTextAttachment` для встраивания изображений
- Fallback на placeholder для отсутствующих изображений

#### 📊 Tables Support
Базовая поддержка таблиц Markdown.

```markdown
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
| Cell 4   | Cell 5   | Cell 6   |
```

```swift
let config = MarkdownConfiguration(
    table: .init(
        headerStyle: .bold,
        borderColor: .gray,
        cellPadding: 8
    )
)
```

**Реализация:**
- Парсер для table синтаксиса
- Создание `NSTextTable` для табличного представления
- Кастомизация стилей заголовков и ячеек

### 🎨 **Version 3.0.0 - Advanced Customization (Q1 2026)**

#### 🎭 Rules-Based Engine
Расширяемая система правил для кастомных элементов.

```swift
// Создание кастомного правила
let mentionRule = CharacterRule(
    pattern: "@(\\w+)",
    style: .foregroundColor(.blue)
)

// Добавление в конфигурацию
let config = MarkdownConfiguration(
    customRules: [mentionRule]
)

// Markdown: Hello @username!
// Результат: Hello @username! (с синим цветом)
```

**Реализация:**
- Протокол `MarkdownRule` для кастомных правил
- Интеграция в основной парсер
- Поддержка регулярных выражений и стилей

#### 🎨 Font Style Enum
Более точный контроль стилей шрифтов.

```swift
let config = MarkdownConfiguration(
    h1: .init(fontStyle: .boldItalic, fontSize: 24),
    code: .init(fontStyle: .monospaced),
    link: .init(fontStyle: .underlined)
)
```

**Реализация:**
- Enum `FontStyle` (.normal, .bold, .italic, .boldItalic, .monospaced, .underlined)
- Расширение `MarkdownStyle` с `fontStyle` свойством
- Применение через `UIFontDescriptor` и `NSFontDescriptor`

#### 🌙 Dark Mode & Theme Support
Полная поддержка тем и цветовых схем.

```swift
let lightConfig = MarkdownConfiguration.lightTheme()
let darkConfig = MarkdownConfiguration.darkTheme()

// Или кастомная тема
let customTheme = MarkdownTheme(
    background: .systemBackground,
    text: .label,
    accent: .systemBlue
)
```

**Реализация:**
- Класс `MarkdownTheme` для цветовых схем
- Методы `lightTheme()` и `darkTheme()` в `MarkdownConfiguration`
- Интеграция с `UITraitCollection` и `NSAppearance`

---

## 🔗 **Similar Projects**

If you're looking for alternative Swift Markdown libraries, check out these excellent projects:

### [SwiftyMarkdown](https://github.com/SimonFairbairn/SwiftyMarkdown) ⭐ 1.7k
- **Author**: Simon Fairbairn
- **Focus**: Comprehensive Markdown parsing with advanced customization
- **Key Features**:
  - Rules-based processing engine
  - Front Matter / YAML support
  - Dynamic Type support
  - SpriteKit integration
  - Extensive styling options
- **Platforms**: iOS, macOS, tvOS, watchOS

### [MarkdownKit](https://github.com/bmoliveira/MarkdownKit) ⭐ 871
- **Author**: Bruno Oliveira
- **Focus**: Lightweight and extensible Markdown parser
- **Key Features**:
  - Regular expression-based parsing
  - Custom element support
  - CocoaPods, Carthage, and SPM support
  - Extensible architecture
- **Platforms**: iOS, macOS

> **Note**: MarkdownToAttributedString was inspired by studying these projects and aims to provide a modern, Swift-first approach with comprehensive cross-platform support and detailed customization options.

---

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
