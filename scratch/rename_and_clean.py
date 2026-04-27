import os
import re

def clean_name(name):
    return re.sub(r'^[0-9]{2}_[A-Z]_', '', name)

def rename_files(root_dir):
    mapping = {}
    for root, dirs, files in os.walk(root_dir):
        if '.git' in dirs: dirs.remove('.git')
        if 'node_modules' in dirs: dirs.remove('node_modules')
        if '.dart_tool' in dirs: dirs.remove('.dart_tool')
        
        for file in files:
            if re.match(r'^[0-9]{2}_[A-Z]_', file):
                old_path = os.path.join(root, file)
                new_file = clean_name(file)
                new_path = os.path.join(root, new_file)
                
                print(f"Renaming: {file} -> {new_file}")
                os.rename(old_path, new_path)
                mapping[file] = new_file
    return mapping

def update_imports(root_dir, mapping):
    for root, dirs, files in os.walk(root_dir):
        if '.git' in dirs: dirs.remove('.git')
        if 'node_modules' in dirs: dirs.remove('node_modules')
        if '.dart_tool' in dirs: dirs.remove('.dart_tool')
        
        for file in files:
            if not file.endswith(('.dart', '.ts', '.js', '.yaml', '.json', '.md')):
                continue
                
            file_path = os.path.join(root, file)
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            original_content = content
            for old_name, new_name in mapping.items():
                # Replace in imports and strings
                content = content.replace(old_name, new_name)
            
            if content != original_content:
                print(f"Updating imports in: {file}")
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)

if __name__ == "__main__":
    base_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform'
    mapping = rename_files(base_path)
    print(f"Renamed {len(mapping)} files. Updating imports...")
    update_imports(base_path, mapping)
    print("Done.")
