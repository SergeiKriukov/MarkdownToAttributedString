# MarkdownToAttributedString Examples

This document provides comprehensive examples of how to use MarkdownToAttributedString in various scenarios.

## 📱 iOS Examples

### Basic Text Display

```swift
import SwiftUI
import MarkdownToAttributedString

struct MarkdownView: View {
    let markdown = """
    # Welcome to iOS
    
    This is a **bold** statement and this is *italic* text.
    
    ## Features
    - Easy integration
    - Custom styling
    - Cross-platform support
    
    Visit [Apple Developer](https://developer.apple.com) for more info.
    """
    
    var body: some View {
        ScrollView {
            Text(AttributedString(markdown.toAttributedString()))
                .padding()
        }
    }
}
```

### Custom Styling

```swift
struct CustomStyledView: View {
    let markdown = "# Custom Styling\n**Bold** and *italic* text"
    
    var body: some View {
        let config = MarkdownConfiguration(
            h1: .init(fontSize: 32, fontWeight: .bold),
            bold: .init(fontWeight: .bold),
            italic: .init(isItalic: true)
        )
        
        Text(AttributedString(markdown.toAttributedString(configuration: config)))
            .padding()
    }
}
```

### Dynamic Content

```swift
struct DynamicMarkdownView: View {
    @State private var markdownText = ""
    @State private var attributedResult = NSAttributedString()
    
    var body: some View {
        VStack {
            TextEditor(text: $markdownText)
                .frame(height: 200)
                .onChange(of: markdownText) { newValue in
                    attributedResult = newValue.toAttributedString()
                }
            
            ScrollView {
                Text(AttributedString(attributedResult))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 300)
        }
        .padding()
    }
}
```

## 🖥️ macOS Examples

### Document Editor

```swift
import AppKit
import MarkdownToAttributedString

class MarkdownDocument: NSDocument {
    var markdownContent = ""
    
    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "DocumentWindowController") as! NSWindowController
        addWindowController(windowController)
    }
    
    func exportToRTF() {
        let attributedString = markdownContent.toAttributedString()
        
        let savePanel = NSSavePanel()
        savePanel.allowedContentTypes = [.rtf]
        savePanel.nameFieldStringValue = "document.rtf"
        
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

### Rich Text Display

```swift
import SwiftUI
import MarkdownToAttributedString

struct MacMarkdownView: View {
    let content = """
    # macOS App
    
    This is a **rich text** display with:
    
    - Custom fonts
    - Multiple styles
    - Easy integration
    
    ## Code Example
    ```swift
    let attributedString = markdown.toAttributedString()
    ```
    """
    
    var body: some View {
        HStack {
            // Markdown source
            VStack(alignment: .leading) {
                Text("Markdown Source")
                    .font(.headline)
                TextEditor(text: .constant(content))
                    .font(.system(.body, design: .monospaced))
            }
            .frame(width: 300)
            
            Divider()
            
            // Rendered result
            VStack(alignment: .leading) {
                Text("Rendered Result")
                    .font(.headline)
                ScrollView {
                    Text(AttributedString(content.toAttributedString()))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}
```

## 🎨 Advanced Styling Examples

### Custom Color Scheme

```swift
let customConfig = MarkdownConfiguration(
    h1: .init(fontSize: 28, fontWeight: .bold, foregroundColor: .systemBlue),
    h2: .init(fontSize: 24, fontWeight: .semibold, foregroundColor: .systemGreen),
    h3: .init(fontSize: 20, fontWeight: .medium, foregroundColor: .systemOrange),
    bold: .init(fontWeight: .bold, foregroundColor: .systemRed),
    italic: .init(isItalic: true, foregroundColor: .systemPurple),
    code: .init(fontSize: 14, fontWeight: .regular, foregroundColor: .systemGray)
)
```

### Theme-based Configuration

```swift
extension MarkdownConfiguration {
    static let lightTheme = MarkdownConfiguration(
        h1: .init(fontSize: 24, fontWeight: .bold),
        h2: .init(fontSize: 20, fontWeight: .semibold),
        bold: .init(fontWeight: .bold),
        italic: .init(isItalic: true)
    )
    
    static let darkTheme = MarkdownConfiguration(
        h1: .init(fontSize: 24, fontWeight: .bold, foregroundColor: .white),
        h2: .init(fontSize: 20, fontWeight: .semibold, foregroundColor: .lightGray),
        bold: .init(fontWeight: .bold, foregroundColor: .white),
        italic: .init(isItalic: true, foregroundColor: .lightGray)
    )
}
```

## 📄 Export Examples

### RTF Export

```swift
func exportToRTF(_ markdown: String) {
    let attributedString = markdown.toAttributedString()
    
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = [.rtf]
    savePanel.nameFieldStringValue = "export.rtf"
    
    savePanel.begin { response in
        if response == .OK, let url = savePanel.url {
            do {
                let rtfData = try attributedString.data(
                    from: NSRange(location: 0, length: attributedString.length),
                    documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]
                )
                try rtfData.write(to: url)
                print("RTF exported successfully")
            } catch {
                print("Export failed: \(error)")
            }
        }
    }
}
```

### Plain Text Export

```swift
func exportToPlainText(_ markdown: String) {
    let attributedString = markdown.toAttributedString()
    let plainText = attributedString.string
    
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = [.plainText]
    savePanel.nameFieldStringValue = "export.txt"
    
    savePanel.begin { response in
        if response == .OK, let url = savePanel.url {
            do {
                try plainText.write(to: url, atomically: true, encoding: .utf8)
                print("Plain text exported successfully")
            } catch {
                print("Export failed: \(error)")
            }
        }
    }
}
```

### Copy to Clipboard

```swift
func copyToClipboard(_ markdown: String) {
    let attributedString = markdown.toAttributedString()
    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    
    // Copy both plain text and RTF
    pasteboard.setString(attributedString.string, forType: .string)
    
    if let rtfData = try? attributedString.data(
        from: NSRange(location: 0, length: attributedString.length),
        documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf]
    ) {
        pasteboard.setData(rtfData, forType: .rtf)
    }
    
    print("Content copied to clipboard")
}
```

## 🔧 Performance Examples

### Lazy Loading

```swift
class MarkdownCache {
    private var cache: [String: NSAttributedString] = [:]
    
    func attributedString(for markdown: String) -> NSAttributedString {
        if let cached = cache[markdown] {
            return cached
        }
        
        let attributedString = markdown.toAttributedString()
        cache[markdown] = attributedString
        return attributedString
    }
}
```

### Batch Processing

```swift
func processMultipleMarkdown(_ markdowns: [String]) -> [NSAttributedString] {
    return markdowns.map { markdown in
        markdown.toAttributedString()
    }
}
```

## 🧪 Testing Examples

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
        XCTAssertTrue(attributedString.string.contains("Bold"))
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

## 📱 Platform-Specific Examples

### iOS with UIKit

```swift
import UIKit
import MarkdownToAttributedString

class MarkdownViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let markdown = """
        # iOS App
        This is **bold** and *italic* text.
        """
        
        textView.attributedText = markdown.toAttributedString()
    }
}
```

### macOS with AppKit

```swift
import AppKit
import MarkdownToAttributedString

class MarkdownDocument: NSDocument {
    @IBOutlet weak var textView: NSTextView!
    
    override func windowControllerDidLoadNib(_ windowController: NSWindowController) {
        super.windowControllerDidLoadNib(windowController)
        
        let markdown = """
        # macOS App
        This is **bold** and *italic* text.
        """
        
        textView.textStorage?.setAttributedString(markdown.toAttributedString())
    }
}
```

These examples should help you get started with MarkdownToAttributedString in your own projects!
