import sys

filepath = 'packages/flutter_core/lib/registry/file_registry.dart'
try:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace('`', '')
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print("Fixed backticks in file_registry.dart")
except Exception as e:
    print(f"Error: {e}")
