import os

build_dir = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\build\web'
for root, dirs, files in os.walk(build_dir):
    for file in files:
        if file.endswith('.json'):
            path = os.path.join(root, file)
            try:
                with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                if 'login_identifier_label' in content:
                    print(f"File: {path}")
                    # Print the line containing it
                    for line in content.splitlines():
                        if 'login_identifier_label' in line:
                            print(f"  -> {line}")
            except Exception as e:
                pass
