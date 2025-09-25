# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

### Planned Features
- [ ] Advanced table support with styling
- [ ] Syntax highlighting for code blocks
- [ ] Custom font support
- [ ] Advanced export formats (PDF, HTML)
- [ ] Real-time preview
- [ ] Plugin system for custom elements
- [ ] Performance optimizations
- [ ] Additional platform support

### Known Issues
- [ ] Complex nested lists may not render perfectly
- [ ] Some edge cases in table parsing
- [ ] Performance could be improved for very large documents
- [ ] Limited customization options for some elements

### Breaking Changes
- None planned for the near future
- All changes will be backward compatible
- Major version bumps will be clearly documented

---

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/SergeiKriukov/MarkdownToAttributedString/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/SergeiKriukov/MarkdownToAttributedString/discussions)
- 📧 **Contact**: [GitHub Profile](https://github.com/SergeiKriukov)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
