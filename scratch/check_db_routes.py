import sqlite3
import os

DB_PATH = os.path.join(os.getcwd(), ".agents", "governance", "governance.db")
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

# Get all columns of roles table
cursor.execute("PRAGMA table_info(roles);")
columns = [col[1] for col in cursor.fetchall()]
print("Columns:", columns)

# Select all roles
cursor.execute("SELECT role_code, role_name, post_login_route, auth_test_status FROM roles;")
for r in cursor.fetchall():
    print(r)

conn.close()
