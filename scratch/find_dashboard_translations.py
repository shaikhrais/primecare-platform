import sqlite3

db_path = r'C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db'
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Search for any keys or translations containing dashboard terms
terms = [
    'Chiropractor Control Center',
    'Chiropractor Dashboard',
    'Active Operations',
    'Optimal productivity',
    'Security Clearance',
    'Level 4 Approved',
    'Zero exceptions logged',
    'Hourly Core Telemetry',
    'Operational Audit Logs',
    'Execute Operational Audit Scan',
    'System initialized.',
    'Security sync complete.'
]

print("Searching for exact terms in translation tables:")
for term in terms:
    cursor.execute("""
        SELECT k.key_code, k.default_text, v.locale_code, v.translated_text
        FROM translation_keys k
        JOIN translation_values v ON k.id = v.key_id
        WHERE k.default_text = ? OR k.key_code = ?
    """, (term, term))
    rows = cursor.fetchall()
    if rows:
        print(f"\nTerm: {term}")
        for r in rows:
            print(f"  Key: {r[0]} | Locale: {r[2]} | Trans: {r[3]}")
    else:
        # Search by LIKE
        cursor.execute("""
            SELECT k.key_code, k.default_text, v.locale_code, v.translated_text
            FROM translation_keys k
            JOIN translation_values v ON k.id = v.key_id
            WHERE k.default_text LIKE ? OR k.key_code LIKE ?
        """, (f"%{term}%", f"%{term}%"))
        rows = cursor.fetchall()
        if rows:
            print(f"\nTerm: {term} (LIKE match)")
            for r in rows[:6]: # limit printed matches
                print(f"  Key: {r[0]} | Default: {r[1]} | Locale: {r[2]} | Trans: {r[3]}")
        else:
            print(f"\nTerm: {term} -> NOT FOUND")

conn.close()
