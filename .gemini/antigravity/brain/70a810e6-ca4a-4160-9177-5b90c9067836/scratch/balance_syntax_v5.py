import os
import re

SCREEN_ROOT = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\offices'

def fix_orchestration_syntax():
    for root, dirs, files in os.walk(SCREEN_ROOT):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                if 'PageTemplate.orchestrate' not in content: continue
                
                # Regex to find the provider line
                # provider: something(...) maybe), ) maybe
                
                def balance_fix(match):
                    provider_code = match.group(1).strip()
                    # Remove trailing junk if any
                    provider_code = re.sub(r'[,\)\s]+$', '', provider_code)
                    
                    open_count = provider_code.count('(')
                    close_count = provider_code.count(')')
                    
                    if open_count > close_count:
                        # Needs closing
                        return f"provider: {provider_code}),"
                    else:
                        # Already balanced or was wrong
                        return f"provider: {provider_code},"

                # Match the provider block
                new_content = re.sub(
                    r"provider: (.*?)[,\s]*\);", 
                    lambda m: f"{balance_fix(m)}\n      );", 
                    content, 
                    flags=re.DOTALL
                )
                
                if new_content != content:
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Corrected Parentheses: {file}")

if __name__ == "__main__":
    fix_orchestration_syntax()
