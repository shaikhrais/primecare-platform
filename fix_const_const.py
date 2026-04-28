import os
import glob

warehouse_files = glob.glob('packages/factory_system/primecare_ui/lib/src/warehouse/offices/*.dart')

for file in warehouse_files:
    with open(file, 'r', encoding='utf-8') as f:
        text = f.read()
        
    text = text.replace('const const SizedBox.shrink()', 'const SizedBox.shrink()')
            
    with open(file, 'w', encoding='utf-8') as f:
        f.write(text)

print("Done fixing const const")
