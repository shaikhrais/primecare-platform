import os
import re

directories_to_scan = [
    r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui",
    r"C:\Users\Admin2\Documents\GitHub\primecare-platform\apps",
]

# Regex patterns
dynamic_data_pattern = re.compile(r"final dynamic data;")
data_fallback_pattern = re.compile(r"data:\s*\{\}")

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    modified = False

    # Replace final dynamic data; -> final Map<String, dynamic>? data;
    if dynamic_data_pattern.search(content):
        content = dynamic_data_pattern.sub(r"final Map<String, dynamic>? data;", content)
        modified = True

    # Replace data: {} -> data: <String, dynamic>{}
    if data_fallback_pattern.search(content):
        content = data_fallback_pattern.sub(r"data: <String, dynamic>{}", content)
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

print("Done processing all forms.")
