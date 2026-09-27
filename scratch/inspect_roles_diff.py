import sqlite3

db_active = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
db_backup = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db.pre_import_backup"

conn_a = sqlite3.connect(db_active)
conn_b = sqlite3.connect(db_backup)

roles_a = set(r[0] for r in conn_a.execute("SELECT role_code FROM roles").fetchall())
roles_b = set(r[0] for r in conn_b.execute("SELECT role_code FROM roles").fetchall())

print("Active roles count:", len(roles_a))
print("Backup roles count:", len(roles_b))
print("Roles in active but not backup:", roles_a - roles_b)
print("Roles in backup but not active:", roles_b - roles_a)

conn_a.close()
conn_b.close()
