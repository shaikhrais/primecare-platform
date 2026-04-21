import os
import re

ui_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\components\forms\admin"

# Regex patterns
dynamic_data_pattern = re.compile(r"final dynamic data;")
data_fallback_pattern = re.compile(r"data: \{\}")

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

for root, _, files in os.walk(ui_dir):
    for file in files:
        if file.endswith(".dart"):
            process_file(os.path.join(root, file))

print("Done processing admin forms.")
