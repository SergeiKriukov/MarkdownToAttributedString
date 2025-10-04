# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-10-04

### Added
- **Strikethrough support** - Added `~~strikethrough text~~` formatting
- **Blockquotes support** - Added `> quote text` blockquotes with nested formatting
- **Enhanced inline element parsing** - Blockquotes now support nested bold, italic, and strikethrough formatting

### Changed
- **Updated MarkdownElementType** - Added `strikethrough` and `blockquote(content:)` cases
- **Enhanced MarkdownConfiguration** - Added `strikethrough` and `blockquote` style configurations
- **Improved parser architecture** - Better handling of nested inline elements in blockquotes

### Features
- **Complete Markdown support** now includes strikethrough and blockquotes
- **Nested formatting** in blockquotes (bold, italic, strikethrough, code, links)
- **Cross-platform strikethrough styling** - Works on iOS, macOS, tvOS, watchOS

## [1.0.0] - 2024-09-25

### Added
- Initial release of MarkdownToAttributedString
- Complete Markdown parsing support
- NSAttributedString conversion with full formatting
- Customizable styling configuration
- Cross-platform support (iOS, macOS, tvOS, watchOS)
- RTF export functionality
- Plain text extraction
- Comprehensive test suite
- Detailed documentation and examples

### Features
- **Headers**: Support for H1-H6 with customizable styling
- **Text Formatting**: Bold, italic, and inline code support
- **Lists**: Both ordered and unordered lists with custom prefixes
- **Code Blocks**: Multi-line code blocks with syntax highlighting support
- **Links**: Clickable links with custom styling
- **Images**: Image support with alt text
- **Tables**: Basic table support (headers and rows)
- **Line Breaks**: Proper line break handling
- **Paragraphs**: Paragraph separation and formatting

### API
- `MarkdownToAttributedString` - Main converter class
- `MarkdownParser` - Markdown parsing functionality
- `AttributedStringConverter` - NSAttributedString conversion
- `MarkdownConfiguration` - Styling configuration
- `MarkdownStyle` - Individual element styling
- `String.toAttributedString()` - Convenience extension

### Configuration
- Font size customization for all elements
- Font weight options (regular, bold, semibold, light)
- Italic text support
- Color customization (platform-specific)
- List prefix styling
- Header hierarchy styling

### Export Options
- RTF format export for document sharing
- Plain text extraction for simple text processing
- Clipboard integration with rich text support
- File system integration for saving documents

### Performance
- Optimized parsing algorithms
- Memory-efficient conversion
- Background processing support
- Caching capabilities for repeated conversions

### Testing
- Comprehensive unit test suite
- Performance benchmarks
- Cross-platform compatibility tests
- Edge case handling
- Memory leak prevention

### Documentation
- Complete API documentation
- Usage examples for all platforms
- Best practices guide
- Performance optimization tips
- Troubleshooting guide

### Examples
- iOS SwiftUI integration
- macOS AppKit integration
- Custom styling examples
- Export functionality examples
- Performance optimization examples

## [0.9.0] - 2024-09-24

### Added
- Initial development version
- Basic Markdown parsing
- NSAttributedString conversion
- Simple styling configuration

### Changed
- Improved parsing accuracy
- Enhanced error handling
- Better performance optimization

### Fixed
- Memory leaks in long documents
- Parsing issues with nested elements
- Styling inconsistencies

## [0.8.0] - 2024-09-23

### Added
- List support (ordered and unordered)
- Code block handling
- Link and image support
- Basic table support

### Changed
- Refactored parser architecture
- Improved element handling
- Enhanced configuration system

### Fixed
- Line break handling
- Paragraph separation
- Nested formatting issues

## [0.7.0] - 2024-09-22

### Added
- Header support (H1-H6)
- Bold and italic text
- Inline code support
- Basic configuration system

### Changed
- Improved parsing performance
- Better error handling
- Enhanced documentation

### Fixed
- Text formatting issues
- Memory management
- Cross-platform compatibility

## [0.6.0] - 2024-09-21

### Added
- Initial parser implementation
- Basic text conversion
- Simple styling support
- Unit test framework

### Changed
- Improved code structure
- Better error handling
- Enhanced documentation

### Fixed
- Parsing edge cases
- Memory leaks
- Performance issues

## [0.5.0] - 2024-09-20

### Added
- Project structure
- Basic Swift package setup
- Initial documentation
- GitHub repository setup

### Changed
- Improved project organization
- Better documentation structure
- Enhanced development workflow

### Fixed
- Build configuration issues
- Documentation formatting
- Package dependencies

---

## Future Releases

### Version 2.1.0 - Typography & Accessibility (Q2 2025)
- [ ] Dynamic Type support for automatic font scaling
- [ ] Custom bullets and markers for lists
- [ ] Text alignment options for headers and blockquotes
- [ ] Improved accessibility features

### Version 2.2.0 - Advanced Markdown (Q3 2025)
- [ ] Front Matter / YAML metadata support
- [ ] Referenced links and images syntax
- [ ] Line spacing and paragraph spacing control
- [ ] Enhanced link styling (underline, color)

### Version 2.3.0 - Rich Content (Q4 2025)
- [ ] Bundle images support (`![alt](<AssetName>)`)
- [ ] Tables support with styling
- [ ] Inline image sizing and positioning
- [ ] Image placeholder customization

### Version 3.0.0 - Advanced Customization (Q1 2026)
- [ ] Rules-based engine for custom Markdown elements
- [ ] Font style enum (.normal, .bold, .italic, .monospaced, etc.)
- [ ] Dark mode and theme support
- [ ] Plugin system for extensibility

### Long-term Vision
- [ ] Syntax highlighting for code blocks
- [ ] Advanced export formats (PDF, HTML, RTF with images)
- [ ] Real-time preview component
- [ ] Cross-platform HTML rendering
- [ ] Performance optimizations for large documents
- [ ] LaTeX/MathJax support

### Known Issues & Limitations
- [ ] Complex nested lists may not render perfectly
- [ ] Some edge cases in table parsing (future feature)
- [ ] Performance could be improved for very large documents
- [ ] Limited customization options for some elements (being addressed)

### Breaking Changes
- None planned for versions 2.x (backward compatible)
- Version 3.0.0 may introduce breaking changes for advanced features
- All breaking changes will be clearly documented with migration guides

---

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/SergeiKriukov/MarkdownToAttributedString/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/SergeiKriukov/MarkdownToAttributedString/discussions)
- 📧 **Contact**: [GitHub Profile](https://github.com/SergeiKriukov)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
