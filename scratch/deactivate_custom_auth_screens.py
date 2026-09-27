import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

custom_auth_screens = ['login', 'forgot_password', 'mfa', 'reset_password']

for code in custom_auth_screens:
    c.execute("UPDATE screens SET active = 0 WHERE screen_code = ?", (code,))

conn.commit()
print("Deactivated custom auth screens in DB to protect them from code generator overwrites.")
conn.close()
