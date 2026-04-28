import re

with open('lib/src/shared/src/components/primecare_app_bar.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    "title: title is String ? Text(title) : title,",
    "title: title is String ? Text(title as String) : title as Widget?,"
)

with open('lib/src/shared/src/components/primecare_app_bar.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed primecare_app_bar")
