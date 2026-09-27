import sqlite3

db_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def get_stats():
    conn = sqlite3.connect(db_path)
    c = conn.cursor()

    # 1. Total screens checked
    c.execute("SELECT COUNT(*) FROM screens")
    total_screens = c.fetchone()[0]

    # 2. Count of screens with zero interactive objects
    c.execute("SELECT COUNT(*) FROM screens WHERE total_interactive_objects = 0")
    zero_interaction = c.fetchone()[0]

    # 3. Count of screens with fewer than 3 interactive objects but > 0
    c.execute("SELECT COUNT(*) FROM screens WHERE total_interactive_objects < 3 AND total_interactive_objects > 0")
    low_interaction = c.fetchone()[0]

    # 4. Count of screens with unclear purpose (UNCLEAR_PURPOSE)
    c.execute("SELECT COUNT(*) FROM screens WHERE screen_purpose_status = 'UNCLEAR_PURPOSE'")
    unclear_purpose = c.fetchone()[0]

    # 5. Count of screens with no user value (NO_USER_VALUE)
    c.execute("SELECT COUNT(*) FROM screens WHERE screen_purpose_status = 'NO_USER_VALUE'")
    no_user_value = c.fetchone()[0]

    # 6. Count of screens with duplicate purpose (DUPLICATE_PURPOSE)
    c.execute("SELECT COUNT(*) FROM screens WHERE screen_purpose_status = 'DUPLICATE_PURPOSE'")
    duplicate_purpose = c.fetchone()[0]

    # 7. Count of screens with clear purpose (CLEAR_PURPOSE)
    c.execute("SELECT COUNT(*) FROM screens WHERE screen_purpose_status = 'CLEAR_PURPOSE'")
    clear_purpose = c.fetchone()[0]

    # 8. Count of false progress screens
    c.execute("SELECT COUNT(*) FROM screens WHERE false_progress = 1")
    false_progress = c.fetchone()[0]

    print("--- REALITY CHECK STATS ---")
    print(f"Total Screens Checked: {total_screens}")
    print(f"Zero Interaction Screens: {zero_interaction}")
    print(f"Low Interaction Screens (1-2): {low_interaction}")
    print(f"Clear Purpose Screens: {clear_purpose}")
    print(f"Unclear Purpose Screens: {unclear_purpose}")
    print(f"No User Value Screens: {no_user_value}")
    print(f"Duplicate Purpose Screens: {duplicate_purpose}")
    print(f"False Progress Screens: {false_progress}")
    print("----------------------------\n")

    # 20 sample useless/low-value screens (order by total_interactive_objects asc)
    c.execute("""
        SELECT screen_name, route_path, total_interactive_objects, button_count, form_field_count, 
               link_count, table_action_count, filter_count, navigation_action_count, 
               screen_purpose_status, screen_purpose
        FROM screens
        WHERE total_interactive_objects < 3 OR screen_purpose_status IN ('NO_USER_VALUE', 'UNCLEAR_PURPOSE')
        ORDER BY total_interactive_objects ASC, screen_name ASC
        LIMIT 25
    """)
    samples = c.fetchall()
    print("--- SAMPLE LOW VALUE SCREENS ---")
    for i, row in enumerate(samples, 1):
        print(f"{i}. Name: {row[0]}")
        print(f"   Route: {row[1]}")
        print(f"   Total Interactive: {row[2]} (Btn: {row[3]}, Form: {row[4]}, Link: {row[5]}, Table: {row[6]}, Filter: {row[7]}, Nav: {row[8]})")
        print(f"   Status: {row[9]}")
        print(f"   Purpose: {row[10]}")
        print()

    conn.close()

if __name__ == "__main__":
    get_stats()
