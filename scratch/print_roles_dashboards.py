import sqlite3
import os

DB_PATH = os.path.join(os.getcwd(), ".agents", "governance", "governance.db")
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

roles = [
    'clinical_director', 'physician', 'cns', 'pediatric', 'guest', 'portal', 'patient',
    'territory_sales', 'hsw', 'rn_field_supervisor', 'np', 'lpn', 'employee', 'volunteer',
    'customer_support', 'qa_specialist', 'family'
]

cursor.execute("""
    SELECT r.role_code, r.default_dashboard_screen_code, r.post_login_route, s.route_path, r.primary_app_code
    FROM roles r
    LEFT JOIN screens s ON r.default_dashboard_screen_code = s.screen_code
    WHERE r.role_code IN ({})
""".format(",".join("?" for _ in roles)), roles)

for row in cursor.fetchall():
    print(f"Role: {row[0]:<20} | Default Screen: {str(row[1]):<30} | DB Post Login Route: {str(row[2]):<40} | Screen Route Path: {str(row[3]):<45} | App: {str(row[4])}")

conn.close()
