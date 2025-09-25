import Foundation
import MarkdownToAttributedString

print("🚀 MarkdownToAttributedString - Демонстрация работы")
print(String(repeating: "=", count: 60))

let sampleMarkdown = """
# Добро пожаловать в MarkdownToAttributedString

Это **библиотека** для конвертации *Markdown* текста в `NSAttributedString`.

## Возможности

### Форматирование текста
- **Жирный текст**
- *Курсивный текст*
- `Инлайновый код`

### Списки
- Маркированный список
- Еще один пункт

1. Нумерованный список
2. Второй элемент

### Ссылки
Посетите [GitHub](https://github.com) для просмотра кода.

### Изображения
![Логотип Swift](https://swift.org/assets/images/swift.svg)
"""

print("📝 Исходный Markdown:")
print(sampleMarkdown)
print("\n" + String(repeating: "=", count: 60))

// Тестируем базовую конвертацию
print("🔄 Конвертация с настройками по умолчанию:")
let converter = MarkdownToAttributedString()
let attributedString = converter.convert(sampleMarkdown)

print("✅ Успешно конвертировано!")
print("📊 Длина результата: \(attributedString.length) символов")
print()

// Тестируем парсер
print("🔍 Разбор на элементы:")
let parser = MarkdownParser()
let elements = parser.parse(sampleMarkdown)

print("📋 Найдено элементов: \(elements.count)")
for (index, element) in elements.prefix(10).enumerated() { // Показываем первые 10 элементов
    let typeDescription: String
    switch element.type {
    case .header(let level):
        typeDescription = "Заголовок H\(level)"
    case .bold:
        typeDescription = "Жирный"
    case .italic:
        typeDescription = "Курсив"
    case .code:
        typeDescription = "Код"
    case .link:
        typeDescription = "Ссылка"
    case .image:
        typeDescription = "Изображение"
    case .unorderedList:
        typeDescription = "Маркированный список"
    case .orderedList:
        typeDescription = "Нумерованный список"
    case .text:
        typeDescription = "Текст"
    default:
        typeDescription = "\(element.type)"
    }

    let content = element.content.count > 50 ?
        String(element.content.prefix(50)) + "..." :
        element.content

    print("  \(index + 1). \(typeDescription): \"\(content)\"")
}

if elements.count > 10 {
    print("  ... и еще \(elements.count - 10) элементов")
}

print("\n" + String(repeating: "=", count: 60))

// Тестируем кастомную конфигурацию
print("🎨 Конвертация с кастомной конфигурацией:")
let customConfig = MarkdownConfiguration(
    h1: .init(fontSize: 32, fontWeight: .bold),
    h2: .init(fontSize: 24, fontWeight: .semibold),
    bold: .init(fontWeight: .bold),
    italic: .init(fontWeight: .regular) // italic пока не реализован
)

let customConverter = MarkdownToAttributedString(configuration: customConfig)
let customAttributedString = customConverter.convert("# Тест\n**Жирный** текст")

print("✅ Кастомная конфигурация применена!")
print("📊 Длина результата: \(customAttributedString.length) символов")

print("\n" + String(repeating: "=", count: 60))

// Тестируем расширение String
print("🔧 Использование расширения String:")
let simpleMarkdown = "# Привет\nЭто *просто* тест"
let extendedResult = simpleMarkdown.toAttributedString()

print("✅ Расширение работает!")
print("📊 Длина результата: \(extendedResult.length) символов")

// Проверяем применение стилей
print("\n" + String(repeating: "=", count: 60))
print("🎨 Проверка применения стилей:")

let simpleTest = "# Тест\n**Жирный** и *курсив* текст"
let testResult = converter.convert(simpleTest)

print("📝 Тестовый текст: \"\(simpleTest)\"")
print("📊 Длина результата: \(testResult.length)")

if testResult.length > 0 {
    // Проверяем атрибуты заголовка
    let headerAttrs = testResult.attributes(at: 0, effectiveRange: nil)
    print("🎯 Атрибуты заголовка: \(headerAttrs.count > 0 ? "присутствуют" : "отсутствуют")")

    // Проверяем атрибуты жирного текста
    if let boldRange = testResult.string.range(of: "Жирный") {
        let nsRange = NSRange(boldRange, in: testResult.string)
        let boldAttrs = testResult.attributes(at: nsRange.location, effectiveRange: nil)
        print("💪 Атрибуты жирного текста: \(boldAttrs.count > 0 ? "присутствуют" : "отсутствуют")")
    }

    // Проверяем атрибуты курсива
    if let italicRange = testResult.string.range(of: "курсив") {
        let nsRange = NSRange(italicRange, in: testResult.string)
        let italicAttrs = testResult.attributes(at: nsRange.location, effectiveRange: nil)
        print("🎭 Атрибуты курсива: \(italicAttrs.count > 0 ? "присутствуют" : "отсутствуют")")
    }

    // Показываем первые несколько атрибутов
    print("📋 Ключи атрибутов: \(Array(headerAttrs.keys))")
}

print("\n" + String(repeating: "=", count: 60))
print("🎉 Демонстрация завершена успешно!")
print("💡 Теперь вы можете использовать библиотеку в своих проектах!")
