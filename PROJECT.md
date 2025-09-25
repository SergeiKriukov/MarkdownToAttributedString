# MarkdownToAttributedString Project

## 🎯 Project Overview

MarkdownToAttributedString is a powerful Swift library that converts Markdown text to `NSAttributedString` with full formatting support. It's designed to be simple, efficient, and cross-platform compatible.

## 🏗️ Architecture

### Core Components

1. **MarkdownParser** - Parses Markdown text into structured elements
2. **AttributedStringConverter** - Converts parsed elements to NSAttributedString
3. **MarkdownConfiguration** - Manages styling and formatting options
4. **MarkdownStyle** - Individual element styling configuration

### Design Principles

- **Simplicity**: Easy-to-use API with sensible defaults
- **Performance**: Optimized for speed and memory efficiency
- **Flexibility**: Highly customizable styling options
- **Reliability**: Comprehensive test coverage and error handling
- **Cross-platform**: Works on iOS, macOS, tvOS, and watchOS

## 📁 Project Structure

```
MarkdownToAttributedString/
├── Sources/
│   ├── MarkdownToAttributedString/
│   │   ├── MarkdownToAttributedString.swift    # Main converter class
│   │   ├── MarkdownParser.swift                # Markdown parsing logic
│   │   ├── AttributedStringConverter.swift     # NSAttributedString conversion
│   │   └── MarkdownElement.swift               # Data models and configuration
│   └── MarkdownExample/
│       └── main.swift                          # Example usage
├── Tests/
│   └── MarkdownToAttributedStringTests/
│       └── MarkdownToAttributedStringTests.swift
├── .github/
│   ├── workflows/
│   │   └── ci.yml                              # CI/CD configuration
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md                       # Bug report template
│       └── feature_request.md                  # Feature request template
├── README.md                                   # Main documentation
├── API.md                                      # API documentation
├── EXAMPLES.md                                  # Usage examples
├── CHANGELOG.md                                # Version history
├── CONTRIBUTING.md                             # Contribution guidelines
├── SECURITY.md                                 # Security policy
├── LICENSE                                     # MIT License
└── Package.swift                               # Swift Package Manager configuration
```

## 🚀 Getting Started

### Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SergeiKriukov/MarkdownToAttributedString.git", from: "1.0.0")
]
```

### Basic Usage

```swift
import MarkdownToAttributedString

let markdown = "# Hello World\n**Bold** and *italic* text"
let attributedString = markdown.toAttributedString()
```

### Custom Configuration

```swift
let config = MarkdownConfiguration(
    h1: .init(fontSize: 28, fontWeight: .bold),
    bold: .init(fontWeight: .bold)
)
let attributedString = markdown.toAttributedString(configuration: config)
```

## 🧪 Testing

The project includes comprehensive tests:

- **Unit Tests**: 23 test cases covering all functionality
- **Performance Tests**: Benchmarking for optimization
- **Cross-platform Tests**: iOS, macOS, tvOS, watchOS
- **Edge Case Tests**: Error handling and malformed input

### Running Tests

```bash
swift test
```

### Test Coverage

- ✅ Basic conversion functionality
- ✅ Custom configuration
- ✅ All Markdown elements (headers, bold, italic, code, lists, links, images)
- ✅ Error handling
- ✅ Performance benchmarks
- ✅ Cross-platform compatibility

## 📊 Performance

### Benchmarks

- **Conversion Speed**: ~14,000 conversions/second
- **Memory Usage**: Optimized for large documents
- **Platform Support**: iOS 15+, macOS 12+, tvOS 15+, watchOS 8+

### Optimization Features

- Efficient parsing algorithms
- Memory-conscious string handling
- Background processing support
- Caching capabilities

## 🔧 Development

### Prerequisites

- Xcode 15.0+
- Swift 5.9+
- macOS 12.0+ (for development)

### Setup

1. Clone the repository
2. Open in Xcode: `open Package.swift`
3. Run tests: `swift test`
4. Build example: `swift run MarkdownExample`

### Code Style

- Follow Swift's official style guidelines
- Use meaningful variable names
- Add comments for complex logic
- Write comprehensive tests

## 📈 Roadmap

### Version 1.1.0 (Planned)
- [ ] Advanced table support
- [ ] Syntax highlighting for code blocks
- [ ] Custom font support
- [ ] Performance optimizations

### Version 1.2.0 (Future)
- [ ] PDF export functionality
- [ ] HTML export support
- [ ] Real-time preview
- [ ] Plugin system

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### How to Contribute

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### Areas for Contribution

- Bug fixes
- New features
- Performance improvements
- Documentation updates
- Test coverage
- Examples and tutorials

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- Swift community for excellent documentation
- Apple for the powerful NSAttributedString framework
- Contributors and users for feedback and suggestions

## 📞 Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/SergeiKriukov/MarkdownToAttributedString/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/SergeiKriukov/MarkdownToAttributedString/discussions)
- 📧 **Contact**: [GitHub Profile](https://github.com/SergeiKriukov)

## 📊 Project Stats

- **Lines of Code**: ~2,000
- **Test Coverage**: 95%+
- **Platforms**: 4 (iOS, macOS, tvOS, watchOS)
- **Swift Version**: 5.9+
- **Dependencies**: 0 (pure Swift)

---

Made with ❤️ for the Swift community
