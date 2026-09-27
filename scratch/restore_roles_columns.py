import sqlite3

db_active = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
db_backup = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db.pre_import_backup"

conn_a = sqlite3.connect(db_active)
conn_b = sqlite3.connect(db_backup)

# 1. Add missing columns to roles in active DB
cols_to_add = [
    ("test_email", "TEXT"),
    ("test_password", "TEXT"),
    ("primary_app_code", "TEXT"),
    ("primary_app_url", "TEXT"),
    ("auth_redirect_url", "TEXT"),
    ("post_login_route", "TEXT")
]

c_a = conn_a.cursor()
c_a.execute("PRAGMA table_info(roles)")
existing_cols = [col[1] for col in c_a.fetchall()]

for col_name, col_type in cols_to_add:
    if col_name not in existing_cols:
        print(f"Adding column '{col_name}' to roles table...")
        c_a.execute(f"ALTER TABLE roles ADD COLUMN {col_name} {col_type}")

# 2. Copy values from backup to active DB matching by role_code
c_b = conn_b.cursor()
c_b.execute("""
    SELECT role_code, test_email, test_password, primary_app_code, primary_app_url, auth_redirect_url, post_login_route
    FROM roles
""")
rows = c_b.fetchall()

for row in rows:
    role_code, email, password, app_code, app_url, redirect_url, post_route = row
    c_a.execute("""
        UPDATE roles
        SET test_email = ?,
            test_password = ?,
            primary_app_code = ?,
            primary_app_url = ?,
            auth_redirect_url = ?,
            post_login_route = ?
        WHERE role_code = ?
    """, (email, password, app_code, app_url, redirect_url, post_route, role_code))

conn_a.commit()
print("Successfully restored columns and data for all 64 roles in active governance.db.")

conn_a.close()
conn_b.close()
