import os
import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

if not os.path.exists(db_path):
    print("DB not found:", db_path)
    exit(1)

# Scan workspace for all screen dart files
screen_files = {}
for root, dirs, files in os.walk(project_root):
    # Skip build/android/ios/etc
    if any(p in root for p in ['.git', 'build', '.dart_tool', '.github', '.agents']):
        continue
    for file in files:
        if file.endswith('_screen.dart') or file.endswith('dashboard.dart'):
            base = file[:-5] # remove .dart
            rel_path = os.path.relpath(os.path.join(root, file), project_root).replace(os.sep, '/')
            screen_files[base.lower()] = rel_path

print(f"Scanned {len(screen_files)} screen files in workspace.")

# Connect to DB
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

cursor.execute("SELECT id, screen_code, actual_file_path FROM screens")
rows = cursor.fetchall()

aligned = 0
for sid, code, current_path in rows:
    code_lower = code.lower()
    
    # Try different key variations
    variants = [
        code_lower,
        f"{code_lower}_screen",
        code_lower.replace("_dashboard", "dashboard"),
        code_lower.replace("_dashboard", "_dashboard_screen"),
        code_lower.replace("_screen", "")
    ]
    
    found_path = None
    for var in variants:
        if var in screen_files:
            found_path = screen_files[var]
            break
            
    if found_path and found_path != current_path:
        cursor.execute("UPDATE screens SET actual_file_path = ? WHERE id = ?", (found_path, sid))
        aligned += 1

conn.commit()
print(f"Aligned {aligned} screen file paths in database.")
conn.close()
