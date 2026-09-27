import sqlite3
conn = sqlite3.connect(".agents/governance/governance.db")
conn.row_factory = sqlite3.Row
cur = conn.cursor()
r = cur.execute("SELECT * FROM roles WHERE role_code = 'chiropractor'").fetchone()
if r:
    print(dict(r))
else:
    print("Role not found")
conn.close()
