import os
import json
import re

def title_case(s):
    # Convert something like "franchise_owner_dashboard_screen" to "Franchise Owner Dashboard Screen"
    return re.sub(r'[A-Za-z]+', lambda match: match.group(0).capitalize(), s.replace('_', ' '))

def main():
    ui_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_ui\lib\src\screens\offices"
    src_base = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations_src\en\offices"

    count_created = 0

    for root, dirs, files in os.walk(ui_dir):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                rel_path = os.path.relpath(file_path, ui_dir)
                
                # Replace backslashes with forward slashes for cross-platform processing
                rel_path_unix = rel_path.replace(os.sep, '/')
                
                # If it's a part/freezed file or starts with underscore, skip
                if file.endswith('.g.dart') or file.endswith('.freezed.dart') or file.startswith('_'):
                    continue
                
                json_rel_path = rel_path.replace('.dart', '.json')
                dest_json_path = os.path.join(src_base, json_rel_path)
                
                # Only create if it doesn't already exist
                if not os.path.exists(dest_json_path):
                    os.makedirs(os.path.dirname(dest_json_path), exist_ok=True)
                    
                    parts = rel_path.replace('.dart', '').split(os.sep)
                    
                    # Work out the translation key prefix (omitting 'offices' if present, per build_i18n.py logic)
                    if parts and parts[0] == 'offices':
                        dot_path = ".".join(parts[1:])
                    else:
                        dot_path = ".".join(parts)
                    
                    base_name = parts[-1]
                    
                    placeholder_data = {
                        "title": f"TBD: {dot_path}.title",
                        "subtitle": f"TBD: {dot_path}.subtitle"
                    }
                    
                    with open(dest_json_path, 'w', encoding='utf-8') as f:
                        json.dump(placeholder_data, f, indent=2)
                        
                    count_created += 1

    print(f"Generated {count_created} missing JSON fragment files in {src_base}")

if __name__ == "__main__":
    main()
