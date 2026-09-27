import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"

def main():
    # Let's search inside packages/flutter_core/lib/routes/
    routes_dir = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "routes")
    for root, dirs, files in os.walk(routes_dir):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                content = open(path, encoding='utf-8').read()
                matches = re.findall(r'(\w*guest\w*Dashboard\w*\s*=\s*[\'\"].*?[\'\"])', content, re.IGNORECASE)
                if matches:
                    print(f"File: {file}")
                    for m in matches:
                        print(f"  {m}")

if __name__ == '__main__':
    main()
