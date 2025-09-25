# Contributing to MarkdownToAttributedString

Thank you for your interest in contributing to MarkdownToAttributedString! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to avoid duplicates
2. **Check the documentation** to ensure it's not a usage question
3. **Provide detailed information** about the problem

#### Bug Reports

When reporting a bug, please include:

- **Description**: Clear description of the issue
- **Steps to reproduce**: Detailed steps to reproduce the problem
- **Expected behavior**: What you expected to happen
- **Actual behavior**: What actually happened
- **Environment**: OS version, Swift version, Xcode version
- **Code sample**: Minimal code that reproduces the issue
- **Screenshots**: If applicable

#### Feature Requests

When requesting a feature, please include:

- **Description**: Clear description of the proposed feature
- **Use case**: Why this feature would be useful
- **Proposed solution**: How you think it should work
- **Alternatives**: Other solutions you've considered
- **Additional context**: Any other relevant information

### Code Contributions

#### Getting Started

1. **Fork the repository**
2. **Clone your fork**:
   ```bash
   git clone https://github.com/your-username/MarkdownToAttributedString.git
   cd MarkdownToAttributedString
   ```
3. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Make your changes**
5. **Test your changes**
6. **Commit your changes**
7. **Push to your fork**
8. **Create a Pull Request**

#### Development Setup

1. **Install Xcode** (latest version recommended)
2. **Install Swift Package Manager** (comes with Xcode)
3. **Clone the repository**
4. **Open in Xcode**:
   ```bash
   open Package.swift
   ```
5. **Run tests**:
   ```bash
   swift test
   ```

#### Code Style

We follow Swift's official style guidelines:

- **Use Swift's built-in formatting** (Xcode's automatic formatting)
- **Follow naming conventions** (camelCase for variables, PascalCase for types)
- **Write clear, self-documenting code**
- **Add comments for complex logic**
- **Use meaningful variable names**

#### Testing

All contributions must include tests:

- **Unit tests** for new functionality
- **Integration tests** for complex features
- **Performance tests** for optimization changes
- **Edge case tests** for error handling

#### Documentation

Update documentation for any changes:

- **API documentation** for new public APIs
- **README updates** for new features
- **Example code** for new functionality
- **Changelog entries** for user-facing changes

## 📋 Pull Request Process

### Before Submitting

1. **Run tests**: `swift test`
2. **Check formatting**: Use Xcode's automatic formatting
3. **Update documentation**: Include relevant documentation updates
4. **Test on multiple platforms**: iOS, macOS, tvOS, watchOS
5. **Performance check**: Ensure no performance regressions

### Pull Request Template

When creating a pull request, please include:

- **Description**: What changes were made and why
- **Type of change**: Bug fix, feature, documentation, etc.
- **Testing**: How the changes were tested
- **Breaking changes**: Any breaking changes and migration path
- **Screenshots**: If applicable
- **Checklist**: Ensure all items are completed

### Review Process

1. **Automated checks** must pass
2. **Code review** by maintainers
3. **Testing** on multiple platforms
4. **Documentation review**
5. **Final approval** and merge

## 🏗️ Development Guidelines

### Architecture

The library follows a modular architecture:

- **MarkdownParser**: Parses Markdown into structured elements
- **AttributedStringConverter**: Converts elements to NSAttributedString
- **MarkdownConfiguration**: Manages styling configuration
- **Extensions**: Convenience methods and platform-specific code

### Adding New Features

1. **Design the API** first
2. **Write tests** before implementation
3. **Implement the feature**
4. **Update documentation**
5. **Add examples**
6. **Update changelog**

### Performance Considerations

- **Avoid memory leaks** in long-running processes
- **Optimize for large documents**
- **Use efficient data structures**
- **Consider background processing**
- **Profile performance changes**

### Platform Support

The library supports multiple platforms:

- **iOS 15.0+**
- **macOS 12.0+**
- **tvOS 15.0+**
- **watchOS 8.0+**

When adding features, consider:

- **Platform-specific APIs** (UIKit vs AppKit)
- **Performance differences** between platforms
- **Memory constraints** on mobile devices
- **User experience** on different platforms

## 🧪 Testing Guidelines

### Unit Tests

Write comprehensive unit tests:

```swift
func testNewFeature() {
    // Arrange
    let input = "test input"
    let expected = "expected output"
    
    // Act
    let result = functionUnderTest(input)
    
    // Assert
    XCTAssertEqual(result, expected)
}
```

### Integration Tests

Test complete workflows:

```swift
func testFullWorkflow() {
    let markdown = "# Test\n**Bold** text"
    let parser = MarkdownParser()
    let converter = AttributedStringConverter()
    
    let elements = parser.parse(markdown)
    let result = converter.convert(elements)
    
    XCTAssertFalse(result.string.isEmpty)
}
```

### Performance Tests

Measure performance impact:

```swift
func testPerformance() {
    let markdown = generateLargeMarkdown()
    
    measure {
        _ = markdown.toAttributedString()
    }
}
```

### Edge Cases

Test edge cases and error conditions:

```swift
func testEdgeCases() {
    // Empty input
    XCTAssertTrue("".toAttributedString().string.isEmpty)
    
    // Malformed input
    let malformed = "**Bold without closing"
    let result = malformed.toAttributedString()
    XCTAssertFalse(result.string.isEmpty)
    
    // Very large input
    let large = String(repeating: "# Header\n", count: 1000)
    let largeResult = large.toAttributedString()
    XCTAssertFalse(largeResult.string.isEmpty)
}
```

## 📚 Documentation Guidelines

### API Documentation

Document all public APIs:

```swift
/// Converts Markdown text to NSAttributedString
/// - Parameter markdown: The Markdown text to convert
/// - Parameter configuration: Optional styling configuration
/// - Returns: NSAttributedString with applied formatting
public func toAttributedString(
    configuration: MarkdownConfiguration = .default
) -> NSAttributedString
```

### Code Comments

Add comments for complex logic:

```swift
// Parse the markdown into structured elements
// This handles all supported Markdown syntax
let elements = parser.parse(markdown)
```

### README Updates

Update README for new features:

- **Add examples** for new functionality
- **Update feature list** if applicable
- **Add new configuration options**
- **Include performance notes**

## 🐛 Bug Fixes

### Identifying Bugs

- **Reproduce the issue** with minimal code
- **Identify the root cause**
- **Check for similar issues**
- **Consider edge cases**

### Fixing Bugs

1. **Write a failing test** that reproduces the bug
2. **Implement the fix**
3. **Ensure the test passes**
4. **Add additional tests** for edge cases
5. **Update documentation** if needed

### Testing Fixes

- **Test the specific bug** that was reported
- **Test related functionality** to ensure no regressions
- **Test edge cases** that might be affected
- **Performance test** if the fix affects performance

## 🚀 Feature Development

### Planning Features

1. **Define the problem** the feature solves
2. **Design the API** for the feature
3. **Consider platform differences**
4. **Plan for testing**
5. **Document the feature**

### Implementing Features

1. **Start with tests**
2. **Implement the core functionality**
3. **Add error handling**
4. **Optimize for performance**
5. **Add documentation**
6. **Create examples**

### Feature Documentation

- **API documentation** for new methods
- **Usage examples** in README
- **Configuration options** if applicable
- **Performance considerations**
- **Platform-specific notes**

## 📝 Release Process

### Version Numbering

We use [Semantic Versioning](https://semver.org/):

- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] Changelog updated
- [ ] Version number updated
- [ ] Tag created
- [ ] Release notes written

## 🤔 Questions?

If you have questions about contributing:

- **Check existing issues** for similar questions
- **Create a new issue** with the "question" label
- **Join discussions** in GitHub Discussions
- **Contact maintainers** directly

## 📄 License

By contributing to MarkdownToAttributedString, you agree that your contributions will be licensed under the MIT License.

## 🙏 Recognition

Contributors will be recognized in:

- **README contributors section**
- **Release notes**
- **GitHub contributors page**
- **Project documentation**

Thank you for contributing to MarkdownToAttributedString! 🎉
