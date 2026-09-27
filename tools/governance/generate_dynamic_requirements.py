import os
import sqlite3

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def generate_business_purpose(screen_name, app_name, role_name):
    return (
        f"Provides a dedicated management interface within the {app_name} module to enable {role_name} "
        f"personnel to oversee, audit, and coordinate operations related to {screen_name.lower()}."
    )

def generate_user_story(screen_name, app_name, role_name):
    return (
        f"As a {role_name}, I want to access the {screen_name} within the {app_name} application "
        f"so that I can review real-time status details, execute core operational workflows, "
        f"and manage my domain responsibilities."
    )

def generate_acceptance_criteria(screen_name, app_name, role_name):
    return (
        f"- The {screen_name} route loads successfully within the {app_name} workspace.\n"
        f"- The interface correctly displays all primary modules and active widgets.\n"
        f"- Role-based access control restricts unauthorized actions, permitting only {role_name} access.\n"
        f"- System telemetry and data tables refresh correctly upon user interaction."
    )

def main():
    print("==============================================================")
    print("DYNAMIC SCREEN REQUIREMENTS GENERATOR")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # Clear existing requirements to prevent duplicates
    c.execute("DELETE FROM screen_requirements")

    # Fetch all screens joined with apps and roles
    c.execute("""
        SELECT s.id, s.screen_code, s.screen_name, 
               COALESCE(a.app_name, 'PrimeCare General') AS app_name, 
               COALESCE(r.role_name, 'Authorized Staff') AS role_name
        FROM screens s
        LEFT JOIN apps a ON s.app_id = a.id
        LEFT JOIN roles r ON s.role_id = r.id
    """)
    screens = [dict(row) for row in c.fetchall()]
    print(f"Loaded {len(screens)} screens to generate requirements for.")

    generated_count = 0

    for scr in screens:
        sid = scr["id"]
        sname = scr["screen_name"]
        aname = scr["app_name"]
        rname = scr["role_name"]

        business_purpose = generate_business_purpose(sname, aname, rname)
        user_story = generate_user_story(sname, aname, rname)
        sidebar_label = sname
        acceptance_criteria = generate_acceptance_criteria(sname, aname, rname)

        c.execute("""
            INSERT INTO screen_requirements (screen_id, business_purpose, user_story, sidebar_label, acceptance_criteria)
            VALUES (?, ?, ?, ?, ?)
        """, (sid, business_purpose, user_story, sidebar_label, acceptance_criteria))
        generated_count += 1

    conn.commit()
    conn.close()

    print("==============================================================")
    print("GENERATION COMPLETED SUCCESSFULLY!")
    print(f"  - Generated requirements for {generated_count} screens.")
    print("==============================================================")

if __name__ == "__main__":
    main()
