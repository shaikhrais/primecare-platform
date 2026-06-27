import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def get_cfo_screens():
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()
    c.execute("""
        SELECT id, screen_name, route_path, actual_file_path, file_path, progress_percent, 
               screen_body_total_interactions, meaningful_interaction_status, 
               business_workflow_score, role_expectation_score, missing_business_features, 
               business_ready, production_ready 
        FROM screens 
        WHERE role_key = 'cfo'
    """)
    rows = c.fetchall()
    print(f"Found {len(rows)} CFO screens:")
    for r in rows:
        print(f"ID: {r['id']} | Name: {r['screen_name']}")
        print(f"  Route: {r['route_path']}")
        print(f"  Progress: {r['progress_percent']}% | Body Interactions: {r['screen_body_total_interactions']} | Status: {r['meaningful_interaction_status']}")
        print(f"  Business Ready: {r['business_ready']} | Prod Ready: {r['production_ready']}")
        print(f"  Business Score: {r['business_workflow_score']} | Role Score: {r['role_expectation_score']}")
        print(f"  Missing Features: {r['missing_business_features'] or 'None'}")
        print()
    conn.close()

if __name__ == "__main__":
    get_cfo_screens()
