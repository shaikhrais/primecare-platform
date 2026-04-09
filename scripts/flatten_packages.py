import os
import glob
import shutil

workspace = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

# Update pubspec.yaml in apps/
app_pubspecs = glob.glob(os.path.join(workspace, "apps", "*", "pubspec.yaml"))
for path in app_pubspecs:
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    
    # Replace relative paths
    content = content.replace("../../packages/shared/flutter_core", "../../packages/flutter_core")
    content = content.replace("../../packages/shared/flutter_ui", "../../packages/flutter_ui")
    
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)

# Remove the empty shared folder if it exists
shared_dir = os.path.join(workspace, "packages", "shared")
try:
    if os.path.exists(shared_dir):
        shutil.rmtree(shared_dir)
except Exception as e:
    pass

print("Paths updated and shared folder removed.")
