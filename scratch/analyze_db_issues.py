import sqlite3
import os

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def main():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. Total and production_ready counts
    c.execute("SELECT COUNT(*) FROM screens")
    total_screens = c.fetchone()[0]
    
    c.execute("SELECT COUNT(*) FROM screens WHERE production_ready = 1")
    prod_ready = c.fetchone()[0]
    
    c.execute("SELECT implementation_status, COUNT(*) FROM screens GROUP BY implementation_status")
    statuses = c.fetchall()
    
    print(f"Total Screens: {total_screens}")
    print(f"Production Ready Screens: {prod_ready}")
    print("Statuses:")
    for row in statuses:
        print(f"  {row[0]}: {row[1]}")

    # 2. Stub screens marked Cypress-ready
    c.execute("SELECT id, screen_code, implementation_status, cypress_ready, cypress_ready_status FROM screens WHERE implementation_status = 'stub' AND (cypress_ready = 1 OR cypress_ready_status = 'ready')")
    stubs_ready = c.fetchall()
    print(f"\nStub screens marked Cypress-ready ({len(stubs_ready)}):")
    for row in stubs_ready:
        print(f"  ID: {row['id']}, Code: {row['screen_code']}, Status: {row['implementation_status']}, CypressReady: {row['cypress_ready']}, CypressReadyStatus: {row['cypress_ready_status']}")

    # 3. Bad route paths
    c.execute("SELECT id, screen_code, route_path FROM screens WHERE route_path LIKE 'packages/%' OR route_path LIKE '%.dart' OR route_path NOT LIKE '/%'")
    bad_routes = c.fetchall()
    print(f"\nBad route paths ({len(bad_routes)}):")
    for row in bad_routes:
        print(f"  ID: {row['id']}, Code: {row['screen_code']}, RoutePath: {row['route_path']}")

    # 4. Zero UI components in ui_components table
    c.execute("""
        SELECT s.id, s.screen_code, COUNT(c.id) as comp_count
        FROM screens s
        LEFT JOIN ui_components c ON s.id = c.screen_id
        GROUP BY s.id, s.screen_code
        HAVING comp_count = 0
    """)
    zero_comps = c.fetchall()
    print(f"\nScreens with zero components in ui_components ({len(zero_comps)}):")
    for row in zero_comps:
        print(f"  ID: {row['id']}, Code: {row['screen_code']}")

    # 5. Zero body interaction screens
    c.execute("""
        SELECT id, screen_code, screen_body_total_interactions, meaningful_interaction_status 
        FROM screens 
        WHERE screen_body_total_interactions = 0 OR screen_body_total_interactions IS NULL
    """)
    zero_interactions = c.fetchall()
    print(f"\nScreens with zero body interactions ({len(zero_interactions)}):")
    for row in zero_interactions[:15]:
        print(f"  ID: {row['id']}, Code: {row['screen_code']}, interactions: {row['screen_body_total_interactions']}, status: {row['meaningful_interaction_status']}")
    if len(zero_interactions) > 15:
        print(f"  ... and {len(zero_interactions) - 15} more.")

    conn.close()

if __name__ == "__main__":
    main()
