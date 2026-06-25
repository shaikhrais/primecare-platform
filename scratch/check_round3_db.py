import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"
conn = sqlite3.connect(db_path)
c = conn.cursor()

routes = [
    '/generated/client-payments',
    '/clinic/client-profile',
    '/generated/client-treatment-history',
    '/generated/family-member-billing',
    '/generated/family-member-care-updates',
    '/generated/family-member-emergency-contacts',
    '/generated/family-member-loved-one-schedule',
    '/generated/family-member-profile',
    '/generated/unknown-dashboard',
    '/offices/client/roles/client/book-appointment',
    '/offices/client/roles/client/care-team',
    '/offices/client/roles/client/my-appointments',
    '/offices/client/roles/client/payments',
    '/offices/client/roles/client/treatment-history',
    '/generated/clinical-director-quality-metrics',
    '/generated/clinical-director-staffing',
    '/generated/infection-control-dashboard',
    '/generated/intake-coordinator-assessments',
    '/generated/nurse-dashboard',
    '/generated/psw-observation-vitals-log',
    '/generated/psw-patient-profile',
    '/generated/psw-schedule',
    '/generated/psw-visit-checklist',
    '/generated/rn-messaging',
    '/generated/clinic-history-logs'
]

print("--- ROUND 3 UPDATED SCREENS IN DB ---")
for r in routes:
    c.execute("""
        SELECT id, screen_name, route_path, total_interactive_objects, production_ready, false_progress, screen_purpose_status
        FROM screens
        WHERE route_path = ?
    """, (r,))
    row = c.fetchone()
    print(f"Route: {r} -> {row}")

# Print new reality check summary stats
c.execute("SELECT COUNT(*) FROM screens WHERE false_progress = 1")
false_progress = c.fetchone()[0]
c.execute("SELECT COUNT(*) FROM screens WHERE total_interactive_objects = 0")
zero_interaction = c.fetchone()[0]
print(f"\nRemaining False Progress: {false_progress}")
print(f"Remaining Zero Interaction: {zero_interaction}")

conn.close()
