import os
import re

def flatten_features(root_dir):
    for root, dirs, files in os.walk(root_dir):
        if 'features' in root:
            # Check if this is a feature root (contains views/controllers/models)
            subdirs = [d for d in dirs if d in ['views', 'controllers', 'models']]
            if subdirs:
                print(f"Flattening feature: {root}")
                feature_path = root
                for subdir in subdirs:
                    subdir_path = os.path.join(feature_path, subdir)
                    for file in os.listdir(subdir_path):
                        old_file_path = os.path.join(subdir_path, file)
                        new_file_path = os.path.join(feature_path, file)
                        
                        if os.path.exists(new_file_path):
                            # Handle collision if necessary, but usually they are unique
                            base, ext = os.path.splitext(file)
                            new_file_path = os.path.join(feature_path, f"{base}_{subdir[:-1]}{ext}")
                        
                        print(f"  Moving {file} to {feature_path}")
                        os.rename(old_file_path, new_file_path)
                    
                    # Remove the empty subdir
                    os.rmdir(subdir_path)

def fix_flattened_imports(root_dir):
    # This pattern matches relative imports into the flattened folders
    # e.g. import '../controllers/my_controller.dart' -> import 'my_controller.dart'
    # e.g. import 'views/my_view.dart' -> import 'my_view.dart'
    patterns = [
        (re.compile(r"import\s+['\"](\.\./)+(views|controllers|models)/([^'\"]+)['\"]"), r"import '\3'"),
        (re.compile(r"import\s+['\"](views|controllers|models)/([^'\"]+)['\"]"), r"import '\2'"),
    ]
    
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                
                original_content = content
                for pattern, replacement in patterns:
                    content = pattern.sub(replacement, content)
                
                if content != original_content:
                    print(f"Fixing imports in {file}")
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(content)

if __name__ == "__main__":
    base_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform'
    flatten_features(base_path)
    fix_flattened_imports(base_path)
    print("Done.")
