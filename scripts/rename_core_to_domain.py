import os

workspace = r"."
target_string = "prime-care-shared"
replacement_string = "@primecare/domain"

def replace_in_files(directory):
    for root, dirs, files in os.walk(directory):
        # Exclude directories
        dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules', 'build', '.dart_tool', 'archive']]
        
        for file in files:
            if not file.endswith(('.ts', '.js', '.json', '.md')):
                continue
            
            # Skip package-lock, we'll let npm handle it 
            if file == "package-lock.json":
                continue

            path = os.path.join(root, file)
            try:
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
            except Exception:
                continue
            
            if target_string in content:
                new_content = content.replace(target_string, replacement_string)
                if new_content != content:
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(new_content)
                    print(f"Updated: {path}")

replace_in_files(workspace)
print("Replacements completed successfully.")
