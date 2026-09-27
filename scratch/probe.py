import os

for root, dirs, files in os.walk(r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core"):
    for file in files:
        if file.endswith(".dart"):
            path = os.path.join(root, file)
            with open(path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
            if "rnFieldSupervisor" in content or "rn_field_supervisor" in content:
                print(f"Found in {file}:")
                for idx, line in enumerate(content.splitlines()):
                    if "rnFieldSupervisor" in line or "rn_field_supervisor" in line:
                        print(f"  Line {idx+1}: {line.strip()}")
