import os
import re

path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_controller.dart'
with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if 'Notifier' in line:
        # Check if it looks like a definition
        if re.search(r'\b(class|abstract|typedef|mixin|const|final|var)\s+Notifier\b', line):
            print(f"Line {i+1}: {line.strip()}")
