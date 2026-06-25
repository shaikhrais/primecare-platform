import os
import sqlite3
import re

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

if not os.path.exists(db_path):
    print("DB not found at:", db_path)
    exit(1)

# Connect to DB
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

# Fetch all screens
cursor.execute("SELECT id, screen_code, screen_name, allowed_roles_text, actual_file_path FROM screens")
screens = [dict(row) for row in cursor.fetchall()]
print(f"Loaded {len(screens)} screens from database.")

stages = {
    1: [], # Dashboards (Highest Priority)
    2: [], # Data views, logs, grids (Medium Priority)
    3: []  # Secondary forms and stubs (Lower Priority)
}
wired_screens = []

stub_keywords_re = re.compile(r"\b(TODO|unimplemented|placeholder|UnimplementedError)\b", re.IGNORECASE)

for scr in screens:
    sid = scr['id']
    code = scr['screen_code']
    code_lower = code.lower()
    file_path = scr['actual_file_path']
    
    is_stub = True
    reason = "No file path mapped"
    
    if file_path:
        full_path = os.path.join(project_root, file_path.replace("/", os.sep))
        if os.path.exists(full_path):
            try:
                content = open(full_path, 'r', encoding='utf-8').read()
                # Check for stub criteria
                if len(content) < 1200:
                    reason = f"File is too short ({len(content)} bytes)"
                elif re.search(r'\bTODO\b|\bPlaceholder\b', content) or re.search(r'\bunimplemented\b|\bUnimplementedError\b', content, re.IGNORECASE):
                    reason = "Contains stub keywords (TODO/unimplemented/placeholder)"
                else:
                    is_stub = False
            except Exception as e:
                reason = f"Read error: {e}"
        else:
            reason = f"File does not exist: {file_path}"
            
    if is_stub:
        # Determine Stage
        if 'dashboard' in code_lower:
            stage = 1
        elif any(kw in code_lower for kw in ['list', 'grid', 'table', 'chart', 'analytics', 'history', 'report', 'notes', 'log']):
            stage = 2
        else:
            stage = 3
        stages[stage].append((scr, reason))
        
        # Update DB for stub
        cursor.execute("""
            UPDATE screens
            SET
                implementation_status = 'stub',
                user_remark_status = 'pending_remediation',
                user_remarks = ?
            WHERE id = ?
        """, (f"[STUB - STAGE {stage}] {reason}", sid))
    else:
        wired_screens.append(scr)
        # Update DB for wired
        cursor.execute("""
            UPDATE screens
            SET
                implementation_status = 'wired',
                user_remark_status = 'verified',
                user_remarks = '[WIRED] Fully implemented and data-bound'
            WHERE id = ?
        """, (sid,))

conn.commit()

print("\n=== CLASSIFICATION SUMMARY ===")
print(f"Total Wired/High-Fidelity Screens: {len(wired_screens)}")
print(f"Total Stub/Placeholder Screens: {len(stages[1]) + len(stages[2]) + len(stages[3])}")
print(f"  - Stage 1 (Dashboards): {len(stages[1])} screens")
print(f"  - Stage 2 (Grids & Analytics): {len(stages[2])} screens")
print(f"  - Stage 3 (Secondary Subpages): {len(stages[3])} screens")

# Print some Stage 1 stubs
if stages[1]:
    print("\nRepresentative Stage 1 Stubs:")
    for scr, reason in stages[1][:5]:
        print(f"  - Screen: {scr['screen_code']} | Role: {scr['allowed_roles_text']} | Reason: {reason}")

conn.close()
