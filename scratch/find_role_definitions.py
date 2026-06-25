import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"

role_defs = []

for root, dirs, files in os.walk(os.path.join(PROJECT_ROOT, "apps")):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            content = open(path, encoding="utf-8", errors="ignore").read()
            
            # Find PlatformRoleDefinition
            matches = re.finditer(r"PlatformRoleDefinition\s*\(\s*role\s*:\s*PlatformRole\.(\w+)\s*,\s*dashboardRoute\s*:\s*([^,]+)", content)
            for m in matches:
                role = m.group(1)
                route = m.group(2).strip().strip("'\"")
                role_defs.append({
                    "file": os.path.relpath(path, PROJECT_ROOT),
                    "role": role,
                    "route": route
                })

out_path = os.path.join(PROJECT_ROOT, "scratch", "role_defs_list.txt")
with open(out_path, "w", encoding="utf-8") as f:
    for r in sorted(role_defs, key=lambda x: x["role"]):
        f.write(f"Role: {r['role']:<25} | Route: {r['route']:<55} | File: {r['file']}\n")

print("Done! Wrote to scratch/role_defs_list.txt")
