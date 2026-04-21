import os
import re

directory = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\scaffolded'

for filename in os.listdir(directory):
    if filename.startswith('05_U_') and filename.endswith('.dart'):
        filepath = os.path.join(directory, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()

        # check if it needs fixing (detecting the broken body: inside Center)
        if 'Center(body:' in content:
            print(f"Fixing typo in {filename}...")
            content = content.replace('Center(body:', 'Center(child:')
            
        # Also handle cases where I might have missed child: body: swap at top level correctly
        # if 'PageTemplate(' in content and 'child:' in content:
        #    ... (already done but maybe too greedy)

        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)

print("Done.")
