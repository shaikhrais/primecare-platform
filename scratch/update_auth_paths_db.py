import sqlite3

DB_PATH = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(DB_PATH)
c = conn.cursor()

c.execute("""
    UPDATE screens 
    SET actual_file_path = 'packages/primecare_ui/lib/src/features/auth/success_profile_view.dart' 
    WHERE screen_code = 'success_profile'
""")

c.execute("""
    UPDATE screens 
    SET actual_file_path = 'packages/primecare_ui/lib/src/features/auth/consent_view.dart' 
    WHERE screen_code = 'consent'
""")

conn.commit()
print("Updated consent and success_profile screen paths in DB.")
conn.close()
