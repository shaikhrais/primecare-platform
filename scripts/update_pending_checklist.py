import re
import os

file_path = 'C:/Users/Admin2/.gemini/antigravity/brain/70a810e6-ca4a-4160-9177-5b90c9067836/master_screen_registry.md'
with open(file_path, 'r', encoding='utf-8') as f:
    registry_content = f.read()

lines = registry_content.split('\n')
all_items = []
current_section = ''

for line in lines:
    if line.startswith('### '):
        current_section = line.strip()
    match = re.match(r'\|\s*([A-Z]{3}-\d{3})\s*\|\s*`([^`]+)`', line)
    if match:
        serial = match.group(1)
        name = match.group(2)
        
        target = name
        if 'Stitch' not in target and 'Routes' not in target:
             target = target.replace('.dart', '')
             if '.' in target: target = target.split('.')[-1]
             if not target.endswith('Stitch') and not target.endswith('Screen'): target += 'Screen'
             if not target.endswith('Stitch'): target += 'Stitch'
             
        if 'AppRoutes.' in name:
             target = name.replace('AppRoutes.', '')
             target = target[0].upper() + target[1:]
             if not target.endswith('Screen'): target += 'Screen'
             target += 'Stitch'
             
        all_items.append((current_section, serial, name, target))

out = ['# Comprehensive Pending Stitch Screens Checklist\n\n']
out.append('This list incorporates all Serial Codes from the Master Screen Registry to ensure no screens are missed in tomorrow UI generation process.\n\n')

current_s = ''
for section, serial, orig, target in all_items:
    if section != current_s:
        out.append(f'\n{section}\n')
        current_s = section
    out.append(f'- [ ] {serial} : `{orig}` -> **`{target}`**\n')

with open('C:/Users/Admin2/.gemini/antigravity/brain/70a810e6-ca4a-4160-9177-5b90c9067836/pending_stitch_screens.md', 'w', encoding='utf-8') as f:
    f.writelines(out)

print(f"Generated {len(all_items)} screens to pending checklist.")
