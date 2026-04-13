import re
import os

fp = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib\dynamic_registry_map.dart'
try:
    with open(fp, 'r', encoding='utf-8') as f:
        text = f.read()

    match = re.search(r'(final Map<String, ProviderOrFamily> dynamicAdapterRegistry = \{)(.*?)(\};)', text, re.DOTALL)
    if match:
        prefix = match.group(1)
        body = match.group(2)
        suffix = match.group(3)

        seen = set()
        new_lines = []
        for line in body.split('\n'):
            if ':' in line and "'" in line:
                key = line.split(':')[0].strip().replace("'", "")
                if key not in seen:
                    seen.add(key)
                    new_lines.append(line)
            else:
                new_lines.append(line)
        
        new_body = '\n'.join(new_lines)
        new_text = text[:match.start()] + prefix + new_body + suffix + text[match.end():]
        with open(fp, 'w', encoding='utf-8') as f:
            f.write(new_text)
        print('Removed duplicate keys')
    else:
        print('Map not found')
except Exception as e:
    print(f"Error: {e}")
