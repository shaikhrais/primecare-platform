import os

root_dir = r'C:\Users\Admin2\Documents\GitHub\primecare-platform'
for root, dirs, files in os.walk(root_dir):
    if 'node_modules' in root:
        continue
    for file in files:
        if 'login_view' in file.lower() or 'login_view.dart' in file.lower():
            print(f"File: {os.path.join(root, file)}")
            
# Also check for files containing 'class LoginView'
for root, dirs, files in os.walk(root_dir):
    if 'node_modules' in root or '.git' in root:
        continue
    for file in files:
        if file.endswith('.dart'):
            path = os.path.join(root, file)
            try:
                with open(path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                if 'class LoginView' in content:
                    print(f"Contains class LoginView: {path}")
            except Exception as e:
                pass
