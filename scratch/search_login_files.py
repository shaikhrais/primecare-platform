import os

root_dir = r'C:\Users\Admin2\Documents\GitHub\primecare-platform'
for root, dirs, files in os.walk(root_dir):
    if 'node_modules' in root:
        continue
    for file in files:
        if file.endswith('.spec.ts') or 'playwright' in file.lower() or 'playwright' in root.lower():
            print(os.path.join(root, file))
