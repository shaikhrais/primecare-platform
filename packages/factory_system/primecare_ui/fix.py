import os
import re

def main():
    dart_files = []
    for root, dirs, files in os.walk('.'):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file))

    for filepath in dart_files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        original_content = content
        
        # Replace `const Text(LocaleKeys` -> `Text(LocaleKeys`
        content = re.sub(r'const\s+Text\(\s*LocaleKeys', r'Text(LocaleKeys', content)
        
        # Replace `const [` -> `[` if followed somewhere by `.tr()`? Let's just remove `const` from `const [` if there's `LocaleKeys` in the file.
        # Actually, let's find `const [` and check if the block contains `.tr()`.
        # Even simpler: just replace `const [` with `[` and `const \w+\(` with `\w+\(` ONLY on lines that contain `.tr()`.
        
        lines = content.split('\n')
        changed = False
        
        for i, line in enumerate(lines):
            # If the line itself has LocaleKeys and const, remove const
            if 'LocaleKeys' in line and 'const ' in line:
                lines[i] = re.sub(r'\bconst\s+', '', line)
                changed = True
            
            # If the line has .tr() and const, remove const
            if '.tr()' in line and 'const ' in line:
                lines[i] = re.sub(r'\bconst\s+', '', line)
                changed = True
                
        # Also, often `const [` is on a previous line to LocaleKeys.
        # Let's find occurrences of `const [` and if the next few lines contain `.tr()`, remove `const`.
        for i in range(len(lines)):
            if 'const [' in lines[i] or 'const {' in lines[i]:
                # look ahead up to 20 lines
                has_tr = False
                for j in range(i, min(i + 20, len(lines))):
                    if '.tr()' in lines[j] or 'LocaleKeys' in lines[j]:
                        has_tr = True
                        break
                    if ']' in lines[j] or '}' in lines[j]:
                        break
                
                if has_tr:
                    lines[i] = lines[i].replace('const [', '[')
                    lines[i] = lines[i].replace('const {', '{')
                    changed = True

            # Also check for `const WidgetName(` 
            if re.search(r'const\s+[A-Z]\w*\(', lines[i]):
                has_tr = False
                for j in range(i, min(i + 20, len(lines))):
                    if '.tr()' in lines[j] or 'LocaleKeys' in lines[j]:
                        has_tr = True
                        break
                    if ')' in lines[j]: # Naive end of constructor, might not work for nested, but good enough for 20 lines.
                        pass
                if has_tr:
                    lines[i] = re.sub(r'\bconst\s+([A-Z]\w*\()', r'\1', lines[i])
                    changed = True

        if changed:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write('\n'.join(lines))

if __name__ == '__main__':
    main()
