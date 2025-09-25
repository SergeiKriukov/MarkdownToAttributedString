import MarkdownToAttributedString

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

// Проверяем атрибуты
if attributedString.length > 0 {
    let range = NSRange(location: 0, length: min(50, attributedString.length))
    let attributes = attributedString.attributes(at: 0, longestEffectiveRange: nil, in: range)
    print("📋 Атрибуты первого символа: \(attributes.keys)")
}

// Тестируем парсер
print("\n🔍 Разбор на элементы:")
let parser = MarkdownParser()
let elements = parser.parse(sampleMarkdown)

print("📋 Найдено элементов: \(elements.count)")
for (index, element) in elements.prefix(5).enumerated() { // Показываем первые 5 элементов
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

    let content = element.content.count > 30 ?
        String(element.content.prefix(30)) + "..." :
        element.content

    print("  \(index + 1). \(typeDescription): \"\(content)\"")
}

print("\n🎉 Тест завершен!")
