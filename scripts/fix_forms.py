import re
import os

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content
    
    # Replace `(n['key'] as dynamic) ?? 'fallback'` with `(n['key'] as String?) ?? 'fallback'`
    # if it falls back to a string literal
    content = re.sub(
        r"\(\s*([^)]*?\[.*?\](?:\[.*?\])?)\s+as\s+dynamic\s*\)\s*\?\?\s*('[^']*'|\"[^\"]*\")",
        r"(\1 as String?) ?? \2",
        content
    )

    # Replace `(n['key'] as dynamic) ?? number`
    content = re.sub(
        r"\(\s*([^)]*?\[.*?\](?:\[.*?\])?)\s+as\s+dynamic\s*\)\s*\?\?\s*([0-9.]+)",
        r"(\1 as num?) ?? \2",
        content
    )
    
    # Replace `n['key']` inside `id:` or `name:` that are required to be Strings, assuming standard names
    content = re.sub(
        r"(id|name|title|subtitle|role|specialization|status|timestamp|icon|color|patientName):\s*(n\[.*?\](?:\?\[.*?\])?),",
        r"\1: (\2 as String?) ?? '',",
        content
    )

    # Fix UI component usages: `_carePlan!['client']?['fullName'] ?? 'Unknown'`
    content = re.sub(
        r"(_carePlan!\[.*?\](?:\?\[.*?\])?)\s*\?\?\s*('[^']*')",
        r"(\1 as String?) ?? \2",
        content
    )

    if original != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

changed = 0
for root, dirs, files in os.walk('packages'):
    if 'node_modules' in root: continue
    for file in files:
        if file.endswith('.dart'):
            if fix_file(os.path.join(root, file)):
                changed += 1

print(f"Patched {changed} files.")
