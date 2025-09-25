import MarkdownToAttributedString

// Простой тест для проверки применения стилей
let testMarkdown = "# Заголовок\n**Жирный** текст"
let converter = MarkdownToAttributedString()
let result = converter.convert(testMarkdown)

print("📊 Длина результата: \(result.length)")

// Проверяем атрибуты в разных позициях
if result.length > 0 {
    // Проверяем первый символ (должен быть заголовок)
    let headerRange = NSRange(location: 0, length: 1)
    let headerAttrs = result.attributes(at: 0, effectiveRange: nil)
    print("🎯 Атрибуты заголовка: \(headerAttrs)")

    // Ищем жирный текст
    let searchString = "Жирный"
    let fullString = result.string
    if let range = fullString.range(of: searchString) {
        let nsRange = NSRange(range, in: fullString)
        let boldAttrs = result.attributes(at: nsRange.location, effectiveRange: nil)
        print("💪 Атрибуты жирного текста: \(boldAttrs)")
    }
}

print("✅ Тест завершен!")
