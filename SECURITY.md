# Security Policy

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x  | :white_check_mark: |
| < 1.0  | :x:                |

## Reporting a Vulnerability

If you discover a security vulnerability in MarkdownToAttributedString, please report it responsibly:

### How to Report

1. **Do NOT** create a public GitHub issue
2. **Email** the maintainer directly: [GitHub Profile](https://github.com/SergeiKriukov)
3. **Include** detailed information about the vulnerability
4. **Provide** steps to reproduce the issue
5. **Wait** for a response before public disclosure

### What to Include

When reporting a security vulnerability, please include:

- **Description**: Clear description of the vulnerability
- **Impact**: Potential impact of the vulnerability
- **Steps to reproduce**: Detailed steps to reproduce the issue
- **Environment**: OS version, Swift version, Xcode version
- **Code sample**: Minimal code that demonstrates the issue
- **Proposed fix**: If you have a suggested fix

### Response Timeline

- **Initial response**: Within 48 hours
- **Status update**: Within 1 week
- **Fix release**: Within 30 days (for critical issues)

### Disclosure Process

1. **Report received** and acknowledged
2. **Investigation** and verification
3. **Fix development** and testing
4. **Release** of patched version
5. **Public disclosure** (if appropriate)

## Security Considerations

### Input Validation

MarkdownToAttributedString processes user input and should be used with caution:

- **Validate input** before processing
- **Sanitize content** from untrusted sources
- **Limit input size** to prevent memory issues
- **Handle errors** gracefully

### Memory Safety

The library is designed with memory safety in mind:

- **Automatic memory management** with Swift's ARC
- **No manual memory allocation**
- **Safe string handling**
- **Bounds checking** for array access

### Platform Security

Consider platform-specific security features:

- **iOS**: App Sandbox restrictions
- **macOS**: File system permissions
- **tvOS**: Limited file system access
- **watchOS**: Memory constraints

## Best Practices

### Safe Usage

```swift
// Validate input before processing
func safeMarkdownConversion(_ input: String) -> NSAttributedString? {
    // Check input length
    guard input.count < 10000 else { return nil }
    
    // Check for malicious content
    guard !input.contains("<script>") else { return nil }
    
    // Process safely
    return input.toAttributedString()
}
```

### Error Handling

```swift
do {
    let attributedString = markdown.toAttributedString()
    // Use the result safely
} catch {
    // Handle errors gracefully
    print("Conversion failed: \(error)")
}
```

### Resource Management

```swift
// Limit resource usage
func processLargeDocument(_ markdown: String) {
    // Process in chunks for large documents
    let chunks = markdown.split(separator: "\n")
    for chunk in chunks {
        let result = String(chunk).toAttributedString()
        // Process chunk
    }
}
```

## Known Security Issues

### None Currently Known

No security vulnerabilities are currently known in MarkdownToAttributedString.

### Past Issues

None reported to date.

## Security Updates

Security updates will be released as needed:

- **Critical issues**: Immediate patch release
- **High severity**: Patch release within 1 week
- **Medium severity**: Next minor release
- **Low severity**: Next major release

## Contact

For security-related questions or reports:

- **Email**: [GitHub Profile](https://github.com/SergeiKriukov)
- **GitHub**: [Security Advisories](https://github.com/SergeiKriukov/MarkdownToAttributedString/security/advisories)
- **Issues**: [GitHub Issues](https://github.com/SergeiKriukov/MarkdownToAttributedString/issues)

## Acknowledgments

We thank the security community for responsible disclosure and helping keep MarkdownToAttributedString secure.

## License

This security policy is part of the MarkdownToAttributedString project and is subject to the same MIT License.
