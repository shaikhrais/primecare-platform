import sqlite3
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

if not os.path.exists(db_path):
    print("Database does not exist at:", db_path)
    exit(1)

conn = sqlite3.connect(db_path)
cursor = conn.cursor()

columns_to_add = [
    ("design_stage", "VARCHAR(50) DEFAULT 'DESIGN_NOT_STARTED'"),
    ("html_stage", "VARCHAR(50) DEFAULT 'HTML_NOT_STARTED'"),
    ("component_stage", "VARCHAR(50) DEFAULT 'COMP_NOT_STARTED'"),
    ("logic_stage", "VARCHAR(50) DEFAULT 'LOGIC_NOT_STARTED'"),
    ("api_stage", "VARCHAR(50) DEFAULT 'API_NOT_STARTED'"),
    ("db_stage", "VARCHAR(50) DEFAULT 'DB_NOT_STARTED'"),
    ("validation_stage", "VARCHAR(50) DEFAULT 'VALIDATION_NOT_STARTED'"),
    ("qa_stage", "VARCHAR(50) DEFAULT 'QA_NOT_STARTED'"),
    ("final_stage", "VARCHAR(50) DEFAULT 'FINAL_NOT_READY'"),
    ("progress_percent", "INT DEFAULT 0"),
    ("blocker", "TEXT NULL"),
    ("next_action", "TEXT NULL"),
]

print("Altering screens table...")
for col_name, col_def in columns_to_add:
    try:
        query = f"ALTER TABLE screens ADD COLUMN {col_name} {col_def}"
        cursor.execute(query)
        print(f"  Added column: {col_name}")
    except sqlite3.OperationalError as e:
        if "duplicate column name" in str(e).lower():
            print(f"  Column {col_name} already exists.")
        else:
            print(f"  Error adding {col_name}: {e}")

conn.commit()

# Verify columns
cursor.execute("PRAGMA table_info(screens)")
cols = [row[1] for row in cursor.fetchall()]
print("\nVerifying added columns in screens table:")
for col_name, _ in columns_to_add:
    if col_name in cols:
        print(f"  [OK] {col_name}")
    else:
        print(f"  [MISSING] {col_name}")

conn.close()
print("Altering completed successfully!")
