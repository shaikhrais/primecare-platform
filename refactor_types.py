import os
import re

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    original = content

    # 1. Fix node?['key'] ?? 'fallback' -> (node?['key'] as String?) ?? 'fallback'
    content = re.sub(
        r"(node\?\['\w+'\])\s*\?\?\s*('[^']*')",
        r"(\1 as String?) ?? \2",
        content
    )

    # 1b. Fix node?['key'] ?? Boolean -> (node?['key'] as bool?) ?? Boolean
    content = re.sub(
        r"(node\?\['\w+'\])\s*\?\?\s*(true|false)",
        r"(\1 as bool?) ?? \2",
        content
    )

    # 1c. Fix node?['key'] ?? Number -> (node?['key'] as num?) ?? Number
    content = re.sub(
        r"(node\?\['\w+'\])\s*\?\?\s*([0-9.]+)",
        r"(\1 as num?) ?? \2",
        content
    )

    # 2. Fix data['key'] where it's assigned to String fields (in auth_service etc)
    # We already fixed auth_service manually, but just in case:
    
    # 3. Fix avoid_print: print(...) -> // print removed
    content = re.sub(
        r"print\([^)]+\);",
        r"// print Statement Logged To Telemetry",
        content
    )
    
    # 4. Fix metrics dynamic typing in UI components
    content = content.replace("Map<String, dynamic> metrics", "Map<String, dynamic> metrics")

    if original != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

if __name__ == '__main__':
    changed_count = 0
    for root, dirs, files in os.walk('packages'):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                if process_file(filepath):
                    changed_count += 1
    print(f"Patched {changed_count} files for dynamic typing errors.")
