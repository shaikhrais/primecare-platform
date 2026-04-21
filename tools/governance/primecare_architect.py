import os
import json
import re
import argparse

class PrimeCareArchitect:
    def __init__(self, config_path):
        with open(config_path, 'r') as f:
            self.config = json.load(f)
            
    def get_project_type(self, path):
        if os.path.exists(os.path.join(path, 'pubspec.yaml')):
            return 'flutter'
        if os.path.exists(os.path.join(path, 'package.json')):
            return 'typescript'
        return None

    def get_layer_id(self, rel_path, project_type):
        rules = self.config['project_rules'].get(project_type, {})
        rel_path = rel_path.replace('\\', '/')
        
        # Check explicit mappings
        for rule in rules.get('mappings', []):
            if rule['pattern'] in rel_path:
                return rule['layer']
        
        return "01" # Default to Infra

    def apply_header(self, file_path, layer_id):
        layer_info = self.config['layers'][layer_id]
        header = f"// Layer: {layer_id}_{layer_info['name']}\n"
        
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            if content.startswith("// Layer:"):
                content = re.sub(r"^// Layer:.*?\n", header, content)
            else:
                content = header + content
                
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
        except Exception as e:
            print(f"Error tagging {file_path}: {e}")

    def refactor(self, target_dir, dry_run=False):
        project_type = self.get_project_type(target_dir)
        if not project_type:
            print(f"Error: Unknown project type at {target_dir}")
            return

        print(f"--- Refactoring {project_type.upper()} Project at {target_dir} ---")
        rules = self.config['project_rules'][project_type]
        
        rename_map = {}
        processed_count = 0

        for root, _, files in os.walk(target_dir):
            if any(ignore in root for ignore in rules['ignore_patterns']):
                continue
                
            for file in files:
                if not any(file.endswith(ext) for ext in rules['extensions']):
                    continue
                if any(ignore in file for ignore in rules['ignore_patterns']):
                    continue
                if re.match(r"^\d{2}_[A-Z]_", file):
                    continue

                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, target_dir)
                
                layer_id = self.get_layer_id(rel_path, project_type)
                code = self.config['layers'][layer_id]['code']
                new_name = f"{layer_id}_{code}_{file}"
                
                print(f"[{layer_id}] {file} -> {new_name}")
                
                if not dry_run:
                    self.apply_header(full_path, layer_id)
                    rename_map[full_path] = os.path.join(root, new_name)
                
                processed_count += 1

        if not dry_run:
            for old, new in rename_map.items():
                try:
                    os.rename(old, new)
                except Exception as e:
                    print(f"Rename failed: {old} -> {new}: {e}")
            print(f"Successfully processed {processed_count} files.")
        else:
            print(f"DRY RUN: Would process {processed_count} files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PrimeCare Architectural Architect")
    parser.add_argument("target", help="Target project directory")
    parser.add_argument("--dry-run", action="store_true", help="Preview changes without applying")
    args = parser.parse_args()
    
    architect = PrimeCareArchitect("tools/governance/config/layers.json")
    architect.refactor(args.target, args.dry_run)
