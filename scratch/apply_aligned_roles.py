import sqlite3
import json

DB_PATH = ".agents/governance/governance.db"

app_urls = {
    "auth": "https://primecare-auth.pages.dev",
    "governance": "https://primecare-governance.pages.dev",
    "corporate": "https://primecare-corporate.pages.dev",
    "franchise": "https://primecare-franchise.pages.dev",
    "clinic": "https://primecare-clinic.pages.dev",
    "client": "https://primecare-client.pages.dev",
    "business_development": "https://primecare-business-development.pages.dev",
    "marketing": "https://primecare-marketing.pages.dev",
    "support": "https://primecare-support.pages.dev",
    "enterprise_blueprint": "https://primecare-enterprise-blueprint.pages.dev",
}

def get_aligned_mapping(role_code):
    r = role_code.lower()
    
    # 1. Client App Roles
    if r in ["patient", "client", "guest", "portal"]:
        return "client", "/offices/client/roles/client/dashboard"
    if r == "family":
        return "client", "/offices/client/roles/family_member/dashboard"
        
    # 2. Clinic App Roles
    if r in ["chiropractor", "physio", "rmt", "social_worker", "therapist", "clinical_director", "rn", "caregiver", "psw", "rpn"]:
        route = f"/offices/clinical/roles/{r}/dashboard"
        if r == "physio":
            route = "/offices/clinical/roles/physiotherapist/dashboard"
        return "clinic", route
    if r == "intake":
        return "clinic", "/offices/clinical/roles/intake_coordinator/dashboard"
    if r == "physician":
        return "clinic", "/clinical/physician-dashboard"
    if r == "cns":
        return "clinic", "/clinical/cns-dashboard"
    if r == "pediatric":
        return "clinic", "/clinical/pediatric-dashboard"
    if r == "hsw":
        return "clinic", "/clinical/hsw-dashboard"
    if r == "rn_field_supervisor":
        return "clinic", "/rn/rn-field-supervisor-dashboard"
    if r == "np":
        return "clinic", "/clinical/np-dashboard"
    if r == "lpn":
        return "clinic", "/clinical/lpn-dashboard"
        
    # 3. Corporate App Roles
    if r in ["ceo", "coo", "cfo", "cto", "shareholder", "legal", "ciso"]:
        return "corporate", f"/offices/corporate/roles/{r}/dashboard"
    if r == "compliance": # complianceManager
        return "corporate", "/offices/corporate/roles/compliance_manager/dashboard"
    if r == "bus_dev": # headOfBusDev
        return "corporate", "/offices/corporate/roles/head_of_bus_dev/dashboard"
    if r == "marketing": # headOfMarketing
        return "corporate", "/offices/corporate/roles/head_of_marketing/dashboard"
    if r == "training_director":
        return "corporate", "/offices/corporate/roles/training_director/dashboard"
    if r == "finance_director":
        return "corporate", "/offices/corporate/roles/finance_director/dashboard"
    if r == "volunteer_coordinator":
        return "corporate", "/offices/corporate/roles/volunteer_coordinator/dashboard"
    if r == "hr_director":
        return "corporate", "/offices/corporate/roles/hr_director/dashboard"
    if r == "cx_director":
        return "corporate", "/offices/corporate/roles/cx_director/dashboard"
        
    # 4. Franchise App Roles
    if r == "owner": # franchiseOwner
        return "franchise", "/offices/franchise/roles/franchise_owner/dashboard"
    if r == "ops_manager": # operationsManager
        return "franchise", "/offices/franchise/roles/operations_manager/dashboard"
    if r == "scheduler":
        return "franchise", "/offices/franchise/roles/scheduler/dashboard"
    if r == "billing_admin":
        return "franchise", "/offices/franchise/roles/billing_admin/dashboard"
    if r == "hr_hiring":
        return "franchise", "/offices/franchise/roles/hr_hiring/dashboard"
        
    # 5. Business Development App Roles
    if r == "regional_manager_usa":
        return "business_development", "/offices/business_development/roles/regional_manager_usa/dashboard"
    if r == "franchise_sales": # franchiseSalesManager
        return "business_development", "/offices/business_development/roles/franchise_sales_manager/dashboard"
    if r == "partnership": # partnershipManager
        return "business_development", "/offices/business_development/roles/partnership_manager/dashboard"
    if r == "regional_bdm":
        return "business_development", "/offices/business_development/roles/regional_bdm/dashboard"
    if r == "gm": # generalManager
        return "business_development", "/offices/business_development/roles/general_manager/dashboard"
    if r == "territory_expansion": # territoryExpansionManager
        return "business_development", "/offices/business_development/roles/territory_expansion_manager/dashboard"
    if r == "territory_sales": # territorySalesManager
        return "business_development", "/offices/business_development/roles/territory_sales_manager/dashboard"
    if r == "regional_manager_ontario":
        return "business_development", "/offices/business_development/roles/regional_manager_ontario/dashboard"
        
    # 6. Marketing App Roles
    if r == "local_marketing": # localMarketingManager
        return "marketing", "/offices/marketing/roles/local_marketing_manager/dashboard"
    if r == "community_outreach":
        return "marketing", "/offices/marketing/roles/community_outreach/dashboard"
        
    # 7. Support App Roles
    if r == "customer_support":
        return "support", "/offices/support/roles/customer_support/dashboard"
    if r == "qa_specialist": # qualityAssurance
        return "support", "/offices/support/roles/quality_assurance/dashboard"
        
    # 8. Governance App Roles (or Universal Registry Roles using governance)
    if r in ["employee", "volunteer", "dynamic", "scrum_master", "infrastructure", "system_verification", "training", "governance", "admin"]:
        route = "/governance/placeholder"
        if r == "employee":
            route = "/staff/employee-dashboard"
        elif r == "volunteer":
            route = "/staff/volunteer-dashboard"
        elif r == "dynamic":
            route = "/common/customer-support-dashboard"
        elif r == "scrum_master":
            route = "/offices/system/roles/scrum_master/dashboard"
        elif r == "infrastructure":
            route = "/common/infrastructure-dashboard"
        elif r == "system_verification":
            route = "/common/qa-dashboard"
        elif r == "training":
            route = "/common/training-hub-dashboard"
        elif r == "governance":
            route = "/common/system-dashboard"
        elif r == "admin":
            route = "/common/office-dashboard"
            
        return "governance", route
        
    return None

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

db_roles = cur.execute("SELECT role_code, primary_app_code, post_login_route FROM roles").fetchall()

updates_count = 0
for db_r in db_roles:
    role_code = db_r["role_code"]
    current_app = db_r["primary_app_code"]
    current_route = db_r["post_login_route"]
    
    aligned = get_aligned_mapping(role_code)
    if aligned:
        app_code, route = aligned
        if app_code != current_app or route != current_route:
            primary_url = app_urls[app_code]
            auth_redirect = f"{primary_url}/auth/callback"
            
            cur.execute("""
                UPDATE roles
                SET primary_app_code = ?,
                    primary_app_url = ?,
                    auth_redirect_url = ?,
                    post_login_route = ?
                WHERE role_code = ?
            """, (app_code, primary_url, auth_redirect, route, role_code))
            print(f"Aligned role '{role_code}': App '{app_code}', Route '{route}'")
            updates_count += 1

conn.commit()
conn.close()
print(f"Successfully aligned {updates_count} roles in SQLite database.")
