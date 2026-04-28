import os
import re

def camel_case(s):
    # Handle both hyphens and underscores
    return ''.join(word.capitalize() for word in s.replace('-', '_').replace('_', ' ').split())

def sanitize(path):
    print(f"Sanitizing {path}...")
    if not os.path.exists(path):
        print(f"Error: {path} not found")
        return

    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split into blocks
    # Pattern: // --- Start of (dir)/(file) ---
    parts = re.split(r'(// --- Start of (.*?)/(.*?) ---)', content)
    
    if len(parts) < 2:
        print("No blocks found. Check markers.")
        return

    new_parts = [parts[0]]
    global_seen_classes = {} # class_name -> first_block_index
    
    # parts[0] is header
    # parts[1] is first marker
    # parts[2] is first feature_dir
    # parts[3] is first file_name
    # parts[4] is first block content
    
    for i in range(1, len(parts), 4):
        marker = parts[i]
        feature_dir = parts[i+1]
        file_name = parts[i+2]
        block_content = parts[i+3]
        
        # Determine prefix from directory name
        dir_name = feature_dir.split('/')[0]
        prefix = camel_case(dir_name)
        
        # 1. Identify all classes in this block
        # We look for 'class Name' but also 'abstract class Name', 'mixin Name', etc.
        class_defs = re.findall(r'(class|abstract class|mixin|enum|extension) ([A-Za-z0-9_]+)', block_content)
        
        # Sort by length descending to avoid partial replacements (e.g. MyClass vs MyClassState)
        class_defs = sorted(class_defs, key=lambda x: len(x[1]), reverse=True)
        
        local_renames = {}
        for type_kind, class_name in class_defs:
            # Skip if already prefixed correctly
            if class_name.startswith(prefix) or class_name.startswith('_' + prefix):
                continue
                
            # Skip common Flutter/Library types just in case they were caught (unlikely with regex)
            if class_name in ['Widget', 'BuildContext', 'State', 'ConsumerState', 'ConsumerWidget', 'StatelessWidget', 'StatefulWidget']:
                continue

            new_name = prefix + class_name if not class_name.startswith('_') else '_' + prefix + class_name.lstrip('_')
            local_renames[class_name] = new_name
            
        # Apply local renames to the block content
        for old_name, new_name in local_renames.items():
            # Use word boundaries to avoid partial matches
            block_content = re.sub(r'(?<!\w)' + old_name + r'(?!\w)', new_name, block_content)
            
        # 2. Fix createState() => _StateName(); where _StateName was renamed but the call wasn't
        # Actually, the local_renames loop above should have handled this if _StateName was in class_defs.
        # But sometimes private classes are not caught by the regex if they are defined differently.
        
        # 3. Handle global duplicates (if two features had same class names even after prefixing)
        # This is rare but possible if dir names are similar.
        current_classes = re.findall(r'(class|abstract class|mixin|enum|extension) ([A-Za-z0-9_]+)', block_content)
        for type_kind, class_name in current_classes:
            if class_name in global_seen_classes:
                # Global duplicate! Append sanitized file name
                file_suffix = camel_case(file_name.replace('.dart', ''))
                unique_name = class_name + file_suffix
                block_content = re.sub(r'(?<!\w)' + class_name + r'(?!\w)', unique_name, block_content)
                print(f"  Global Duplicate resolved: {class_name} -> {unique_name} in {feature_dir}")
            else:
                global_seen_classes[class_name] = i

        new_parts.append(marker)
        new_parts.append(block_content)
        
    final_content = "".join(new_parts)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(final_content)
    print("Done.")

if __name__ == "__main__":
    sanitize(r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features\features_view.dart')
