import sqlite3
import os
import json

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

# Define our robust mapping arrays for all 64 roles
CLINIC_ROLES = [
    "chiropractor", "physio", "rmt", "social_worker", "therapist", 
    "clinical_director", "intake", "rn", "physician", "cns", 
    "pediatric", "caregiver", "psw", "hsw", "rn_field_supervisor", 
    "np", "rpn", "lpn"
]

CORPORATE_ROLES = [
    "ceo", "cfo", "ciso", "coo", "cto", "cx_director", 
    "finance_director", "hr_director", "legal", "shareholder", 
    "training_director"
]

FRANCHISE_ROLES = [
    "owner", "franchise_sales"
]

CLIENT_ROLES = [
    "portal", "patient", "family", "guest"
]

BD_ROLES = [
    "bus_dev", "regional_bdm", "territory_expansion", "territory_sales", "partnership"
]

MARKETING_ROLES = [
    "marketing", "local_marketing", "community_outreach"
]

GOVERNANCE_ROLES = [
    "governance", "compliance", "infrastructure", "system_verification", 
    "training", "training_coordinator"
]

SUPPORT_ROLES = [
    "ops_manager", "scrum_master", "volunteer_coordinator", "volunteer", 
    "scheduler", "customer_support", "qa_specialist", "premium_concierge", 
    "vip_manager", "employee", "dynamic", "admin", "gm", "hr_hiring", 
    "regional_manager_usa"
]

def main():
    print("==============================================================")
    print("PRIMECARE MIGRATION: ADD ROLE APP URL FIELDS")
    print("==============================================================")

    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()

    # 1. Alter table roles to add new columns (with try-except to be idempotent)
    columns_to_add = [
        ("primary_app_code", "TEXT"),
        ("primary_app_url", "TEXT"),
        ("auth_redirect_url", "TEXT"),
        ("post_login_route", "TEXT")
    ]

    for col_name, col_type in columns_to_add:
        try:
            cur.execute(f"ALTER TABLE roles ADD COLUMN {col_name} {col_type};")
            print(f"Added column: {col_name}")
        except sqlite3.OperationalError as e:
            if "duplicate column name" in str(e).lower() or "already exists" in str(e).lower():
                print(f"Column '{col_name}' already exists.")
            else:
                raise e

    conn.commit()

    # 2. Map and update all 64 roles
    roles = cur.execute("SELECT id, role_code, sidebar_config_json FROM roles").fetchall()
    print(f"\nProcessing {len(roles)} roles in SQLite database...")

    updated_count = 0

    for r in roles:
        role_id = r["id"]
        role_code = r["role_code"]
        sidebar_json = r["sidebar_config_json"]

        # Determine app classification
        app_code = ""
        app_slug = ""

        if role_code in CLINIC_ROLES:
            app_code = "clinic"
            app_slug = "clinic"
        elif role_code in CORPORATE_ROLES:
            app_code = "corporate"
            app_slug = "corporate"
        elif role_code in FRANCHISE_ROLES:
            app_code = "franchise"
            app_slug = "franchise"
        elif role_code in CLIENT_ROLES:
            app_code = "client"
            app_slug = "client"
        elif role_code in BD_ROLES:
            app_code = "business_development"
            app_slug = "business-development"
        elif role_code in MARKETING_ROLES:
            app_code = "marketing"
            app_slug = "marketing"
        elif role_code in GOVERNANCE_ROLES:
            app_code = "governance"
            app_slug = "governance"
        elif role_code in SUPPORT_ROLES:
            app_code = "support"
            app_slug = "support"
        else:
            # Safe fallback if any undefined role appears
            print(f"  Warning: Unknown role '{role_code}'. Defaulting to 'support'.")
            app_code = "support"
            app_slug = "support"

        primary_url = f"https://primecare-{app_slug}.pages.dev"
        redirect_url = f"https://primecare-{app_slug}.pages.dev/auth/callback"

        # Determine post login route from sidebar config
        post_login = "/"
        if sidebar_json:
            try:
                sidebar_data = json.loads(sidebar_json)
                if "items" in sidebar_data and len(sidebar_data["items"]) > 0:
                    post_login = sidebar_data["items"][0].get("route", "/")
            except Exception as e:
                print(f"  Warning: Could not parse sidebar JSON for role '{role_code}': {e}")

        cur.execute("""
            UPDATE roles
            SET primary_app_code = ?,
                primary_app_url = ?,
                auth_redirect_url = ?,
                post_login_route = ?
            WHERE id = ?;
        """, (app_code, primary_url, redirect_url, post_login, role_id))
        
        updated_count += 1
        print(f"  Role '{role_code}' -> App: '{app_code}', Route: '{post_login}'")

    conn.commit()
    conn.close()
    print(f"\nMigration finished. Successfully updated {updated_count} role records.")

if __name__ == '__main__':
    main()
