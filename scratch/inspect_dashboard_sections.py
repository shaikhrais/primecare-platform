import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
c = conn.cursor()

c.execute("""
    SELECT section_name, section_code, section_type, section_order, file_path
    FROM screen_sections
    WHERE screen_id = 61
    ORDER BY section_order
""")
print("="*60)
print("Sections for psw_dashboard (ID: 61):")
print("="*60)
for r in c.fetchall():
    print(r)
    
conn.close()
