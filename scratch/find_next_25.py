import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
c = conn.cursor()

# Get column names
c.execute("PRAGMA table_info(screens)")
columns = [row[1] for row in c.fetchall()]
print(f"Columns in screens table: {columns}\n")

# Query screens based on priority:
# 1. false_progress = 1
# 2. total_interactive_objects = 0
# 3. screen_purpose_status = 'NO_USER_VALUE'
# 4. visual_score <= 2 (or similar rating column, we'll check if visual_score column exists, else order by other fields)
# 5. route is user-facing (does not contain '/admin/' or '/internal/')

# Let's check if visual_score exists
visual_score_col = "visual_score" if "visual_score" in columns else "1"

query = f"""
    SELECT id, screen_name, route_path, actual_file_path, total_interactive_objects, false_progress, screen_purpose_status
    FROM screens
    WHERE false_progress = 1 
      AND total_interactive_objects = 0
      AND screen_purpose_status = 'NO_USER_VALUE'
      AND route_path NOT LIKE '%/admin%'
      AND route_path NOT LIKE '%/internal%'
    ORDER BY id ASC
    LIMIT 25
"""

c.execute(query)
rows = c.fetchall()
print(f"Candidate Screens Found: {len(rows)}")
for i, r in enumerate(rows, 1):
    print(f"INDEX: {i} | ID: {r[0]} | Name: {r[1]} | Route: {r[2]} | File: {r[3]}")


conn.close()
