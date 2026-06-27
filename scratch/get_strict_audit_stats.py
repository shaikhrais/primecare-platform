import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def get_stats():
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. Total roles
    c.execute("SELECT COUNT(DISTINCT role_key) FROM screens WHERE role_key IS NOT NULL")
    total_roles = c.fetchone()[0]

    # 2. Total screens
    c.execute("SELECT COUNT(*) FROM screens")
    total_screens = c.fetchone()[0]

    # 3. Screens with zero screen-body interactions
    c.execute("SELECT COUNT(*) FROM screens WHERE screen_body_total_interactions = 0")
    zero_body_int = c.fetchone()[0]

    # 4. Screens with only global navigation
    c.execute("SELECT COUNT(*) FROM screens WHERE meaningful_interaction_status = 'ZERO_SCREEN_BODY_INTERACTION'")
    only_global_nav = c.fetchone()[0]

    # 5. Screens marked useless
    c.execute("SELECT COUNT(*) FROM screens WHERE meaningful_interaction_status = 'USELESS_SCREEN'")
    useless_screens = c.fetchone()[0]

    # 6. Screens marked read-only valid
    c.execute("SELECT COUNT(*) FROM screens WHERE meaningful_interaction_status = 'READ_ONLY_VALID'")
    readonly_valid = c.fetchone()[0]

    print("=== STRICT RE-AUDIT STATISTICS ===")
    print(f"1. Total Roles: {total_roles}")
    print(f"2. Total Screens: {total_screens}")
    print(f"3. Screens with Zero Screen-Body Interactions: {zero_body_int}")
    print(f"4. Screens with Only Global Navigation: {only_global_nav}")
    print(f"5. Screens Marked Useless: {useless_screens}")
    print(f"6. Screens Marked Read-Only Valid: {readonly_valid}")
    print("==================================\n")

    # 7. Top 10 roles with most useless screens
    c.execute("""
        SELECT role_name, COUNT(*) as cnt 
        FROM screens 
        WHERE meaningful_interaction_status = 'USELESS_SCREEN' 
        GROUP BY role_name 
        ORDER BY cnt DESC 
        LIMIT 10
    """)
    top_useless_roles = c.fetchall()
    print("=== TOP 10 ROLES WITH MOST USELESS SCREENS ===")
    for idx, row in enumerate(top_useless_roles, 1):
        print(f"{idx}. {row['role_name']}: {row['cnt']} useless screens")
    print("==============================================\n")

    # 8. Sample 20 screens downgraded from useful to not useful (false_progress = 1)
    c.execute("""
        SELECT screen_name, route_path, role_name, global_navigation_count, meaningful_interaction_status
        FROM screens
        WHERE false_progress = 1
        ORDER BY screen_name ASC
        LIMIT 20
    """)
    downgraded = c.fetchall()
    print("=== SAMPLE 20 DOWNGRADED SCREENS ===")
    for idx, row in enumerate(downgraded, 1):
        print(f"{idx}. Screen: {row['screen_name']}")
        print(f"   Route: {row['route_path']}")
        print(f"   Role: {row['role_name']}")
        print(f"   Global Nav Count: {row['global_navigation_count']}")
        print(f"   New Status: {row['meaningful_interaction_status']}")
        print()
    print("=====================================")

    conn.close()

if __name__ == "__main__":
    get_stats()
