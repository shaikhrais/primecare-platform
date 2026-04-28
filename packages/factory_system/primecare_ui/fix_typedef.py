import re

with open('lib/src/shared/primecare_adapters.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("typedef Provider<T> = Provider<T>;\n", "")

with open('lib/src/shared/primecare_adapters.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Removed Provider typedef")
