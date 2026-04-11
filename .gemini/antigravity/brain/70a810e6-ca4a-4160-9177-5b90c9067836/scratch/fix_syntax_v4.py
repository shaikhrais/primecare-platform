import os
import re

SCREEN_ROOT = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\offices'

def fix_syntax():
    for root, dirs, files in os.walk(SCREEN_ROOT):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                if 'PageTemplate.orchestrate' not in content: continue
                
                # Fix missing closing parenthesis on provider family calls
                # Look for provider: something(...) ,
                # and ensure it has balanced parentheses.
                
                new_content = re.sub(
                    r"provider: (.*?),\s+\);", 
                    lambda m: f"provider: {m.group(1)}),\n      );", 
                    content, 
                    flags=re.DOTALL
                )
                
                # Also fix BuildContext
                new_content = new_content.replace('Widget context,', 'BuildContext context,')
                
                if new_content != content:
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Fixed Syntax: {file}")

if __name__ == "__main__":
    fix_syntax()
