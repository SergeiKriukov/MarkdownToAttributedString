import MarkdownToAttributedString

// Тест для проверки форматирования списков
let testMarkdown = """
# Тест списков

## Маркированные списки
- Первый пункт списка
- Второй пункт списка
- Третий пункт списка

## Нумерованные списки
1. Первый нумерованный пункт
2. Второй нумерованный пункт
3. Третий нумерованный пункт

## Смешанный текст
Это обычный текст с **жирным** и *курсивом*.
"""

print("📝 Исходный Markdown:")
print(testMarkdown)
print("\n" + String(repeating: "=", count: 60))

let converter = MarkdownToAttributedString()
let result = converter.convert(testMarkdown)

print("✅ Конвертация завершена")
print("📊 Длина результата: \(result.length)")

// Проверяем, что списки имеют правильные префиксы
let fullText = result.string
print("\n📋 Полный текст результата:")
print(fullText)

// Проверяем атрибуты в местах списков
if let bulletRange = fullText.range(of: "• Первый пункт списка") {
    let nsRange = NSRange(bulletRange, in: fullText)
    let bulletAttrs = result.attributes(at: nsRange.location, effectiveRange: nil)
    print("\n🎯 Атрибуты маркера списка: \(bulletAttrs)")
}

if let numberRange = fullText.range(of: "1. Первый нумерованный пункт") {
    let nsRange = NSRange(numberRange, in: fullText)
    let numberAttrs = result.attributes(at: nsRange.location, effectiveRange: nil)
    print("\n🔢 Атрибуты номера списка: \(numberAttrs)")
}
