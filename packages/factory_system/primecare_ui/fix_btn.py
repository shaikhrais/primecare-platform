import re

with open('lib/src/shared/src/core/primecare_components.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("const PrimeCareButton({", "PrimeCareButton({", 1)

with open('lib/src/shared/src/core/primecare_components.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Removed const from PrimeCareButton")
