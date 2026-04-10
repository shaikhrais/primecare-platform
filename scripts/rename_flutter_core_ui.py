import os
import glob

workspace = r"."

# Update pubspec.yaml in apps/
app_pubspecs = glob.glob(os.path.join(workspace, "apps", "*", "pubspec.yaml"))
for path in app_pubspecs:
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    
    content = content.replace("primecare_core:\n    path: ../../packages/primecare_core", "flutter_core:\n    path: ../../packages/shared/flutter_core")
    content = content.replace("primecare_ui:\n    path: ../../packages/primecare_ui", "flutter_ui:\n    path: ../../packages/shared/flutter_ui")
    
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)

# Update import statements in apps/ and packages/
def replace_in_dart_files(directory):
    for root, dirs, files in os.walk(directory):
        if ".dart_tool" in root or "node_modules" in root or "build" in root:
            continue
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                with open(path, "r", encoding="utf-8") as f:
                    content = f.read()
                
                new_content = content.replace("package:primecare_core", "package:flutter_core")
                new_content = new_content.replace("package:primecare_ui", "package:flutter_ui")
                
                if new_content != content:
                    with open(path, "w", encoding="utf-8") as f:
                        f.write(new_content)

replace_in_dart_files(os.path.join(workspace, "apps"))
replace_in_dart_files(os.path.join(workspace, "packages", "shared", "flutter_core"))
replace_in_dart_files(os.path.join(workspace, "packages", "shared", "flutter_ui"))

print("Replacements completed successfully.")
