import sqlite3
import os

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
c = conn.cursor()

routes = [
    '/offices/clinical/roles/clinical_director/dashboard-dup-1',
    '/common/customer-support-dashboard',
    '/common/system-dashboard',
    '/offices/corporate/roles/cfo/dashboard',
    '/offices/corporate/roles/coo/dashboard',
    '/offices/corporate/roles/cto/dashboard',
    '/offices/corporate/roles/shareholder/dashboard'
]

print("--- DASHBOARD SCREENS IN DB ---")
for r in routes:
    c.execute("select id, screen_name, route_path, total_interactive_objects, production_ready, false_progress from screens where route_path = ?", (r,))
    row = c.fetchone()
    print(f"Route: {r} -> {row}")

conn.close()
