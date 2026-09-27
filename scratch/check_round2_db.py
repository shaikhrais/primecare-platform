import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
c = conn.cursor()

ids = list(range(639, 664)) # IDs 639 to 663 inclusive is 25 screens

print("--- ROUND 2 UPDATED SCREENS IN DB ---")
for screen_id in ids:
    c.execute("""
        SELECT id, screen_name, route_path, total_interactive_objects, production_ready, false_progress, screen_purpose_status
        FROM screens
        WHERE id = ?
    """, (screen_id,))
    row = c.fetchone()
    print(f"ID: {screen_id} -> {row}")

# Print new reality check summary stats
c.execute("SELECT COUNT(*) FROM screens WHERE false_progress = 1")
false_progress = c.fetchone()[0]
c.execute("SELECT COUNT(*) FROM screens WHERE total_interactive_objects = 0")
zero_interaction = c.fetchone()[0]
print(f"\nRemaining False Progress: {false_progress}")
print(f"Remaining Zero Interaction: {zero_interaction}")

conn.close()
