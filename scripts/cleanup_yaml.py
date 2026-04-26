import re
import os

path = r'.agents/governance/page_inventory.yaml'
if not os.path.exists(path):
    print(f"File not found: {path}")
    exit(1)

with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Remove navigation.items. prefix
content = re.sub(r'label:\s*"navigation\.items\.([^"]+)"', 
                 lambda m: f'label: "{m.group(1).replace("_", " ").title()}"', 
                 content)

# Remove navigation.sections. prefix
content = re.sub(r'section:\s*"navigation\.sections\.([^"]+)"', 
                 lambda m: f'section: "{m.group(1).replace("_", " ").title()}"', 
                 content)

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Successfully cleaned up page_inventory.yaml")
