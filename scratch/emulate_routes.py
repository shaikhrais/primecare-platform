import sqlite3
import json

DB_PATH = ".agents/governance/governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Load all roles
roles = cur.execute("SELECT role_code, primary_app_code, post_login_route FROM roles").fetchall()

# Load all screens to emulate PlatformScreenRegistry
screens = cur.execute("SELECT screen_code, route_path, app_id, cypress_ready FROM screens").fetchall()

# App code to app_id mapping in SQLite
app_ids = {
    "clinic": 6,
    "corporate": 7,
    "franchise": 9,
    "client": 5,
    "business_development": 4,
    "marketing": 11,
    "support": 12,
    "governance": 10,
}

# Emulate getDashboardRouteForRole logic in Dart
def emulate_dashboard_route(role_code, app_code):
    r = role_code.lower().replace(' ', '_').replace('/', '_')
    role_upper = role_code.upper().replace(' ', '_')
    
    app_id = app_ids.get(app_code)
    
    # 1. Emulate PlatformScreenRegistry check (filtered by the app_id)
    # Check if there is a screen ending in _DASHBOARD with role_upper in its code or allowed roles.
    # Note: in Dart, it checks s.id.endsWith('_DASHBOARD') and s.roles.contains(roleUpper).
    # Since we don't have the exact roles array, we check screen_code endings and if the screen is relevant to the role.
    app_screens = [s for s in screens if s["app_id"] == app_id]
    
    # Check for direct dashboard match
    for s in app_screens:
        sc = s["screen_code"].upper()
        # In Flutter, screen ID is usually screen_code in uppercase.
        if sc.endswith('_DASHBOARD'):
            # Check if screen is for this role specifically
            if role_upper in sc or sc.startswith(role_upper):
                return s["route_path"]
                
    # Fallback mappings in getDashboardRouteForRole
    # Corporate Leadership
    if r in ['ceo', 'founder']: return '/offices/corporate/roles/ceo/dashboard'
    if r == 'shareholder': return '/offices/corporate/roles/shareholder/dashboard'
    if r == 'coo': return '/offices/corporate/roles/coo/dashboard'
    if r == 'cfo': return '/offices/corporate/roles/cfo/dashboard'
    if r == 'cto': return '/offices/corporate/roles/cto/dashboard'
    if r == 'legal': return '/offices/corporate/roles/legal/dashboard'
    if r == 'ciso': return '/offices/corporate/roles/ciso/dashboard'
    if r == 'compliance_manager' or r == 'compliance': return '/offices/corporate/roles/compliance_manager/dashboard'
    if r == 'head_of_bus_dev' or r == 'bus_dev': return '/offices/corporate/roles/head_of_bus_dev/dashboard'
    if r == 'head_of_marketing' or r == 'marketing': return '/offices/corporate/roles/head_of_marketing/dashboard'
    if r == 'training_director': return '/offices/corporate/roles/training_director/dashboard'
    if r == 'finance_director': return '/offices/corporate/roles/finance_director/dashboard'
    if r == 'volunteer_coordinator': return '/offices/corporate/roles/volunteer_coordinator/dashboard'
    if r == 'hr_director': return '/offices/corporate/roles/hr_director/dashboard'
    if r == 'cx_director': return '/offices/corporate/roles/cx_director/dashboard'

    # Business Development
    if r == 'regional_manager_ontario': return '/offices/business_development/roles/regional_manager_ontario/dashboard'
    if r == 'regional_manager_usa': return '/offices/business_development/roles/regional_manager_usa/dashboard'
    if r == 'franchise_sales_manager' or r == 'franchise_sales': return '/offices/business_development/roles/franchise_sales_manager/dashboard'
    if r == 'partnership_manager' or r == 'partnership': return '/offices/business_development/roles/partnership_manager/dashboard'
    if r == 'territory_expansion_manager' or r == 'territory_expansion': return '/offices/business_development/roles/territory_expansion_manager/dashboard'
    if r == 'general_manager' or r == 'gm': return '/offices/business_development/roles/general_manager/dashboard'
    if r == 'territory_sales_manager' or r == 'territory_sales': return '/offices/business_development/roles/territory_sales_manager/dashboard'
    if r == 'regional_bdm': return '/offices/business_development/roles/regional_bdm/dashboard'

    # Franchise Tier
    if r in ['franchise_owner', 'owner']: return '/offices/franchise/roles/franchise_owner/dashboard'
    if r == 'operations_manager' or r == 'ops_manager': return '/offices/franchise/roles/operations_manager/dashboard'
    if r in ['scheduler', 'coordinator']: return '/offices/franchise/roles/scheduler/dashboard'
    if r in ['billing_admin', 'billing']: return '/offices/franchise/roles/billing_admin/dashboard'
    if r in ['hr_manager', 'hr_hiring']: return '/offices/franchise/roles/hr_hiring/dashboard'

    # Support & Institutional
    if r in ['customer_support', 'support']: return '/offices/support/roles/customer_support/dashboard'
    if r == 'intake': return '/offices/clinical/roles/intake_coordinator/dashboard'
    if r in ['quality_assurance', 'qa_manager', 'qa_specialist']: return '/offices/support/roles/quality_assurance/dashboard'
    if r == 'training_coordinator': return '/offices/support/roles/training_coordinator/dashboard'
    if r == 'receptionist': return '/common/receptionist-dashboard'
    if r == 'scrum_master': return '/offices/system/roles/scrum_master/dashboard'
    if r == 'guest': return '/offices/client/roles/client/dashboard'

    # Marketing & Growth
    if r == 'local_marketing': return '/offices/marketing/roles/local_marketing_manager/dashboard'
    if r == 'outreach' or r == 'community_outreach': return '/offices/marketing/roles/community_outreach/dashboard'

    # Clinical Execution
    if r == 'clinical_director': return '/offices/clinical/roles/clinical_director/dashboard'
    if r == 'psw': return '/offices/clinical/roles/psw/dashboard'
    if r == 'chiropractor': return '/offices/clinical/roles/chiropractor/dashboard'
    if r in ['physio', 'physiotherapist']: return '/offices/clinical/roles/physiotherapist/dashboard'
    if r == 'rmt': return '/offices/clinical/roles/rmt/dashboard'
    if r == 'social_worker': return '/offices/clinical/roles/social_worker/dashboard'
    if r == 'therapist': return '/offices/clinical/roles/therapist/dashboard'
    if r == 'caregiver': return '/offices/clinical/roles/caregiver/dashboard'
    if r == 'rn': return '/offices/clinical/roles/rn/dashboard'
    if r == 'rpn': return '/offices/clinical/roles/rpn/dashboard'
    if r == 'clinical': return '/common/clinical-dashboard'

    # Client Side
    if r == 'client' or r == 'portal' or r == 'patient': return '/offices/client/roles/client/dashboard'
    if r == 'family': return '/offices/client/roles/family_member/dashboard'

    # Institutional Fallbacks
    if r == 'admin': return '/common/office-dashboard'
    if r == 'employee': return '/staff/employee-dashboard'
    if r == 'volunteer': return '/staff/volunteer-dashboard'
    if r == 'dynamic': return '/common/customer-support-dashboard'
    if r == 'infrastructure': return '/common/infrastructure-dashboard'
    if r == 'system_verification': return '/common/qa-dashboard'
    if r == 'training': return '/common/training-hub-dashboard'
    if r == 'governance': return '/common/system-dashboard'

    return '/common/clinical-dashboard'

mismatches = []
for role in roles:
    role_code = role["role_code"]
    app_code = role["primary_app_code"]
    db_route = role["post_login_route"]
    
    emulated_route = emulate_dashboard_route(role_code, app_code)
    if db_route != emulated_route:
        mismatches.append({
            "role_code": role_code,
            "app_code": app_code,
            "db_route": db_route,
            "emulated_route": emulated_route
        })

print(f"Found {len(mismatches)} mismatches:")
for m in mismatches:
    print(f"  Role '{m['role_code']}' in app '{m['app_code']}': DB route = '{m['db_route']}', Emulated route = '{m['emulated_route']}'")

conn.close()
