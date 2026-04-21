import os
import re

def absolute_sync():
    # Use full paths if possible for reliability
    package_root = os.path.abspath('packages/factory_system/primecare_ui/lib')
    package_name = 'primecare_ui'
    
    # 1. Map every basename to its absolute package URI
    uri_map = {}
    print(f"Mapping package URIs in {package_root}...")
    for root, dirs, files in os.walk(package_root):
        for f in files:
            if f.endswith('.dart'):
                rel_path = os.path.relpath(os.path.join(root, f), package_root).replace('\\', '/')
                full_uri = f"package:{package_name}/{rel_path}"
                
                # Store the mapping
                uri_map[f] = full_uri
                # If it's a layered name, also map the plain name
                if re.match(r'^0\d_[A-Z]_', f):
                    plain_name = f[5:]
                    if plain_name not in uri_map:
                        uri_map[plain_name] = full_uri

    print(f"Mapped {len(uri_map)} filenames to absolute URIs.")

    # 2. Update every file
    updated_count = 0
    pattern = re.compile(r'(import|export)\s+([\'\"])(.*?\.dart)([\'\"])')
    
    for root, dirs, files in os.walk(package_root):
        for f in files:
            if f.endswith('.dart'):
                path = os.path.join(root, f)
                try:
                    with open(path, 'r', encoding='utf-8') as file:
                        content = file.read()
                except UnicodeDecodeError:
                    continue

                original_content = content
                
                def replace_uri(match):
                    line = match.group(0)
                    uri = match.group(3)
                    
                    basename = os.path.basename(uri)
                    if basename in uri_map:
                        # Ensure we don't double-replace if it's already Correct
                        target_uri = uri_map[basename]
                        if uri != target_uri:
                            return line.replace(uri, target_uri)
                    
                    return line

                new_content = pattern.sub(replace_uri, content)

                if new_content != original_content:
                    with open(path, 'w', encoding='utf-8') as file:
                        file.write(new_content)
                    updated_count += 1
                elif f == '01_I_clinical_glass.dart':
                    # Debug print for clinical_glass as we know it has issues
                    print(f"DEBUG: Analyzed 01_I_clinical_glass.dart but no changes made.")
                    # Let's check some matches manually if possible? 
                    # No, we'll just check why it didn't change.

    print(f"Repaired {updated_count} files in 'primecare_ui' using absolute package URIs.")

if __name__ == "__main__":
    absolute_sync()
