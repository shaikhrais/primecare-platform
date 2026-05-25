import sqlite3
import os

db_path = os.path.join(".agents", "governance", "governance.db")
conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cursor = conn.cursor()

cursor.execute("""
    SELECT id, task_title, task_description, priority, task_type, related_screen_id, related_api_id, related_file_id, status
    FROM implementation_tasks
    WHERE status = 'pending'
    ORDER BY CASE priority 
        WHEN 'critical' THEN 1 
        WHEN 'high' THEN 2 
        WHEN 'medium' THEN 3 
        WHEN 'low' THEN 4 
        ELSE 5 
    END, created_at ASC
    LIMIT 1;
""")
row = cursor.fetchone()

if row:
    print("=== Highest Priority Pending Task ===")
    print(f"ID: {row['id']}")
    print(f"Title: {row['task_title']}")
    print(f"Description: {row['task_description']}")
    print(f"Priority: {row['priority']}")
    print(f"Type: {row['task_type']}")
    print(f"Screen ID: {row['related_screen_id']}")
    print(f"API ID: {row['related_api_id']}")
    print(f"File ID: {row['related_file_id']}")
    print(f"Status: {row['status']}")
else:
    print("No pending tasks found in implementation_tasks table!")

conn.close()
