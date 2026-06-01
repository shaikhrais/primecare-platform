import sqlite3
conn = sqlite3.connect('.agents/governance/governance.db')
r = conn.execute("SELECT role_code, post_login_route FROM roles WHERE role_code='chiropractor'").fetchone()
print("Chiropractor role row:", dict(zip(["role_code", "post_login_route"], r)) if r else "NOT FOUND")
conn.close()
