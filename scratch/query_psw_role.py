import sqlite3

db_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Get psw role information
cursor.execute("SELECT role_code, role_name, show_language_switcher FROM roles WHERE role_code = 'psw';")
role = cursor.fetchone()
print("PSW Role Information:")
if role:
    print(f"  Role Code: {role[0]}")
    print(f"  Role Name: {role[1]}")
    print(f"  Show Language Switcher: {role[2]}")
else:
    print("  PSW role not found!")

# Get language switcher visible in screens table for psw dashboard
cursor.execute("SELECT screen_code, screen_name, language_switcher_visible, language_kpi_score, language_kpi_status FROM screens WHERE screen_code = 'psw_dashboard';")
screen = cursor.fetchone()
print("\nPSW Dashboard Screen Information:")
if screen:
    print(f"  Screen Code: {screen[0]}")
    print(f"  Screen Name: {screen[1]}")
    print(f"  Language Switcher Visible (expected): {screen[2]}")
    print(f"  Language KPI Score: {screen[3]}")
    print(f"  Language KPI Status: {screen[4]}")
else:
    print("  psw_dashboard screen not found!")

conn.close()
