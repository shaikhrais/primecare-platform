import os
import re

def camel_case(s):
    return ''.join(word.capitalize() for word in s.replace('-', '_').replace('_', ' ').split())

def fix_file(path):
    print(f"Fixing {path}...")
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split by start markers
    # Using a more robust split that keeps the markers
    parts = re.split(r'(// --- Start of .*/.* ---)', content)
    
    new_parts = [parts[0]]
    for i in range(1, len(parts), 2):
        marker = parts[i]
        # Extract feature path from marker
        match = re.search(r'// --- Start of (.*?)/.* ---', marker)
        if not match:
            new_parts.append(marker)
            if i+1 < len(parts):
                new_parts.append(parts[i+1])
            continue
            
        feature_path = match.group(1)
        feature_name = camel_case(feature_path.split('/')[0])
        block_content = parts[i+1]
        
        # Find all renamed classes in this block: class _FeatureName_OriginalName
        # Note: the original name might have started with _ or not.
        # The merge script used: _ + Prefix + _ + OriginalName.lstrip('_')
        
        # Let's find all classes matching the pattern
        renamed_classes = re.findall(r'class (_' + feature_name + r'_(\w+))', block_content)
        
        for full_renamed_name, original_suffix in renamed_classes:
            # We look for _original_suffix() or original_suffix() in the block
            # and replace it with full_renamed_name()
            
            # Case 1: _OriginalName()
            pattern1 = r'(?<!\w)_' + original_suffix + r'\(\)'
            block_content = re.sub(pattern1, full_renamed_name + '()', block_content)
            
            # Case 2: OriginalName() (if it didn't start with _)
            pattern2 = r'(?<!\w)' + original_suffix + r'\(\)'
            block_content = re.sub(pattern2, full_renamed_name + '()', block_content)

        new_parts.append(marker)
        new_parts.append(block_content)
        
    final_content = "".join(new_parts)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(final_content)

if __name__ == "__main__":
    base_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'
    fix_file(os.path.join(base_path, 'features_view.dart'))
