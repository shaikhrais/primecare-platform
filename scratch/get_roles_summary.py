import sqlite3

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
c = conn.cursor()

print("Total roles detected:")
c.execute("SELECT COUNT(*) FROM role_screen_audit")
print(c.fetchone()[0])

print("\nTop 10 roles with most incomplete screens:")
c.execute("SELECT role_name, incomplete_count FROM role_screen_audit ORDER BY incomplete_count DESC LIMIT 10")
for row in c.fetchall():
    print(f"- {row['role_name']}: {row['incomplete_count']}")

print("\nTop 10 roles with most false progress screens:")
c.execute("SELECT role_name, false_progress_count FROM role_screen_audit ORDER BY false_progress_count DESC LIMIT 10")
for row in c.fetchall():
    print(f"- {row['role_name']}: {row['false_progress_count']}")

conn.close()
