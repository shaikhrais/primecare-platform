import os
import re
import argparse

class PrimeCareSync:
    def __init__(self, root_dir):
        self.root_dir = root_dir
        self.rename_map = {} # basename -> new_basename

    def scan_renames(self, target_dir):
        """Builds a map of old_basename -> new_basename by looking at 0X_L_ prefixes."""
        for root, _, files in os.walk(target_dir):
            for file in files:
                if re.match(r"^\d{2}_[A-Z]_", file):
                    # Extract old basename by removing the prefix
                    old_basename = file[5:]
                    self.rename_map[old_basename] = file
        print(f"Captured {len(self.rename_map)} renaming rules.")

    def sync_imports(self, dry_run=False):
        """Recursively repairs imports in all Dart and TS files."""
        # Sort by length descending to prevent partial matches
        sorted_keys = sorted(self.rename_map.keys(), key=len, reverse=True)
        
        file_count = 0
        update_count = 0
        
        for root, dirs, files in os.walk(self.root_dir):
            if any(x in root for x in [".git", "node_modules", "build", ".dart_tool"]):
                continue
                
            for file in files:
                if not any(file.endswith(ext) for ext in [".dart", ".ts", ".js", ".tsx"]):
                    continue
                
                file_path = os.path.join(root, file)
                file_count += 1
                
                try:
                    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                        content = f.read()
                    
                    new_content = content
                    changed = False
                    
                    for old_base in sorted_keys:
                        new_base = self.rename_map[old_base]
                        
                        # Match 'old_base' or "old_base" or /old_base
                        # We use unique quotes to isolate filenames in strings
                        patterns = [
                            (f"'{old_base}'", f"'{new_base}'"),
                            (f'"{old_base}"', f'"{new_base}"'),
                            (f"/{old_base}", f"/{new_base}")
                        ]
                        
                        for p_old, p_new in patterns:
                            if p_old in new_content:
                                new_content = new_content.replace(p_old, p_new)
                                changed = True
                    
                    if changed:
                        if not dry_run:
                            with open(file_path, 'w', encoding='utf-8') as f:
                                f.write(new_content)
                        update_count += 1
                        
                except Exception as e:
                    print(f"Error syncing {file}: {e}")

        status = "DRY RUN: Would update" if dry_run else "Updated"
        print(f"Scanned {file_count} files. {status} imports in {update_count} files.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PrimeCare Import Synchronizer")
    parser.add_argument("--root", default=".", help="Root search directory")
    parser.add_argument("--scan", required=True, help="Directory to scan for renamed files")
    parser.add_argument("--dry-run", action="store_true", help="Preview changes")
    args = parser.parse_args()
    
    sync = PrimeCareSync(args.root)
    sync.scan_renames(args.scan)
    sync.sync_imports(args.dry_run)
