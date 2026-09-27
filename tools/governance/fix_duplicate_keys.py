import os
import re

SCREENS_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "packages", "primecare_ui", "lib", "src", "screens"))

def deduplicate_keys(file_path):
    with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    # Let's split into lines and filter duplicate keys
    lines = content.splitlines(keepends=True)
    new_lines = []
    
    # We will keep track of keys seen recently to avoid duplicate key: args in the same widget block
    recent_keys = []
    dup_count = 0
    
    for line in lines:
        stripped = line.strip()
        
        # Match something like: key: const Key('...') or key: Key('...')
        key_match = re.search(r"key\s*:\s*(?:const\s+)?Key\s*\(\s*['\"]([^'\"]+)['\"]\s*\)", stripped)
        
        if key_match:
            key_val = key_match.group(1)
            # If we saw this exact key in the last 4 lines, it's a duplicate parameter in the same widget constructor
            if key_val in recent_keys:
                dup_count += 1
                continue # Skip this duplicate key!
            
            recent_keys.append(key_val)
            if len(recent_keys) > 5:
                recent_keys.pop(0)
        else:
            # Clear or age the recent keys if we hit structural boundaries
            if "}" in stripped or "{" in stripped or ";" in stripped:
                recent_keys = []
                
        new_lines.append(line)

    if dup_count > 0:
        new_content = "".join(new_lines)
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        return True, dup_count
        
    return False, 0

def main():
    print("==============================================================")
    print("DEDUPLICATING DART KEY CONSTRUCTOR ARGUMENTS")
    print("==============================================================")
    
    if not os.path.exists(SCREENS_DIR):
        print(f"Error: Screens directory not found at {SCREENS_DIR}")
        return

    fixed_files = 0
    total_dups = 0
    scanned_count = 0

    for root, dirs, files in os.walk(SCREENS_DIR):
        for file in files:
            if not file.endswith(".dart"):
                continue
            
            scanned_count += 1
            file_path = os.path.join(root, file)
            
            modified, count = deduplicate_keys(file_path)
            if modified:
                fixed_files += 1
                total_dups += count

    print(f"Scanned {scanned_count} files.")
    print(f"Fixed {fixed_files} files, removing {total_dups} duplicate keys!")

if __name__ == "__main__":
    main()
