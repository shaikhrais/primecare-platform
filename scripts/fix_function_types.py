import os
import re

directories_to_scan = [
    r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src",
    r"C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_corporate\lib",
    r"C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_clinic\lib",
]

function_map_pattern = re.compile(r"final Function\(Map<String, dynamic>\)")
function_aura_pattern = re.compile(r"final Function\(AuraIntent\)\?")

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    modified = False

    if function_map_pattern.search(content):
        content = function_map_pattern.sub(r"final void Function(Map<String, dynamic>)", content)
        modified = True

    if function_aura_pattern.search(content):
        content = function_aura_pattern.sub(r"final void Function(AuraIntent)?", content)
        modified = True

    if modified:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed {os.path.basename(filepath)}")

for directory in directories_to_scan:
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                process_file(os.path.join(root, file))

print("Done fixing function types.")
