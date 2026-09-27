import re

file_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\ui\dynamic_screen_view.dart"

with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# Find all occurrences of Key('...')
pattern = re.compile(r"Key\(\s*['\"]([^'\"]+)['\"]")
matches = pattern.findall(content)
print(f"Exposed Keys: {matches}")
