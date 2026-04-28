import re

with open('lib/src/shared/src/core/primecare_components.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("Text(insight.message,", "Text(insight.summary.en,")

with open('lib/src/shared/src/core/primecare_components.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Replaced insight.message with insight.summary.en")
