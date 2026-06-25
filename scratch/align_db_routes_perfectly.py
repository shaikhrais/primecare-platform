import re
import os
import sqlite3

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

PLATFORM_ROLES = [
  "ceo", "coo", "cfo", "cto", "complianceManager", "governanceOfficer", "headOfBusDev", "headOfMarketing",
  "trainingDirector", "financeDirector", "scrumMaster", "hrDirector", "cxDirector", "shareholder", "legal",
  "ciso", "itAdmin", "regionalManagerOntario", "regionalManagerUsa", "regionalBdm", "franchiseSalesManager",
  "partnershipManager", "territoryExpansionManager", "territorySalesManager", "generalManager", "localMarketingManager",
  "communityOutreach", "franchiseOwner", "operationsManager", "scheduler", "billingAdmin", "hrHiring",
  "hrManager", "owner", "clinicalDirector", "intakeCoordinator", "qualityAssurance", "trainingCoordinator",
  "volunteerCoordinator", "receptionist", "psw", "rn", "rpn", "rmt", "chiropractor", "physiotherapist",
  "socialWorker", "clinic", "patient", "customerSupport", "intake", "qa", "support", "therapist",
  "physician", "cns", "pediatric", "caregiver", "premiumConcierge", "vipManager", "hsw", "rnFieldSupervisor",
  "np", "lpn", "employee", "volunteer", "qaSpecialist", "trainingDirectorCertificate", "trainingHub",
  "courseArchitect", "architecturePlanning", "systemVerification", "dynamicScreen", "client", "familyMember",
  "guest", "admin", "system", "corporate", "franchise", "office", "clinical", "portal", "infrastructure",
  "businessDevelopment", "unknown"
]

def from_name(role_name):
    if not role_name:
        return "guest"
    
    cleaned = role_name.strip()
    while ((cleaned.startswith('"') and cleaned.endswith('"') and len(cleaned) >= 2) or
           (cleaned.startswith("'") and cleaned.endswith("'") and len(cleaned) >= 2)):
        cleaned = cleaned[1:-1].strip()
        
    normalized = cleaned.lower().replace('_', '').replace(' ', '')
    
    if normalized == 'superadmin': return 'admin'
    if normalized == 'physio': return 'physiotherapist'
    if normalized == 'intake': return 'intakeCoordinator'
    if normalized == 'compliance': return 'complianceManager'
    if normalized == 'gm': return 'generalManager'
    if normalized == 'busdev': return 'headOfBusDev'
    if normalized == 'marketing': return 'headOfMarketing'
    if normalized == 'opsmanager': return 'operationsManager'
    if normalized == 'regionalmanagerusa': return 'regionalManagerUsa'
    if normalized == 'scrummaster': return 'scrumMaster'
    if normalized == 'hrhiring': return 'hrHiring'
    if normalized == 'territoryexpansion': return 'territoryExpansionManager'
    if normalized == 'territorysales': return 'territorySalesManager'
    if normalized == 'volunteercoordinator': return 'volunteerCoordinator'
    if normalized == 'family': return 'familyMember'
    if normalized == 'training': return 'trainingHub'
    if normalized == 'dynamic': return 'dynamicScreen'
    if normalized == 'owner': return 'franchiseOwner'
    if normalized == 'franchisesales': return 'franchiseSalesManager'
    if normalized == 'partnership': return 'partnershipManager'
    if normalized == 'premiumconcierge': return 'premiumConcierge'
    if normalized == 'vipmanager': return 'vipManager'
    if normalized == 'qaspecialist': return 'qaSpecialist'
    if normalized == 'localmarketing': return 'localMarketingManager'
    if normalized == 'governance': return 'governanceOfficer'
    
    for val in PLATFORM_ROLES:
        val_lower = val.lower()
        val_snake_lower = re.sub(r'([A-Z])', r'_\1', val).lower().replace('_', '')
        if val_lower == normalized or val_snake_lower == normalized:
            return val
            
    return 'guest'

def main():
    print("==============================================================")
    print("PRIMECARE ROUTE ALIGNMENT: REALIGNING DB TO DART AUTH ROUTER")
    print("==============================================================")

    # 1. Parse all Route Constants
    routes_dir = os.path.join(PROJECT_ROOT, 'packages', 'flutter_core', 'lib', 'routes', 'groups')
    route_mappings = {}

    for filename in os.listdir(routes_dir):
        if filename.endswith('.dart'):
            filepath = os.path.join(routes_dir, filename)
            content = open(filepath, encoding='utf-8').read()
            
            class_match = re.search(r'class\s+(\w+)', content)
            if class_match:
                class_name = class_match.group(1)
                constants = re.findall(r'static\s+const\s+String\s+(\w+)\s*=\s*[\'"]([^\'"]+)[\'"]', content)
                for name, val in constants:
                    route_mappings[f"{class_name}.{name}"] = val

    # 2. Parse platform_screen_registry.dart
    registry_path = os.path.join(PROJECT_ROOT, 'packages', 'flutter_core', 'lib', 'registry', 'platform_screen_registry.dart')
    registry_content = open(registry_path, encoding='utf-8').read()

    screens = {}
    pos = 0
    while True:
        match = re.search(r"'(\w+)'\s*:\s*ScreenMetadata\(", registry_content[pos:])
        if not match:
            break
        screen_id = match.group(1)
        start_idx = pos + match.end()
        depth = 1
        i = start_idx
        while i < len(registry_content) and depth > 0:
            if registry_content[i] == '(':
                depth += 1
            elif registry_content[i] == ')':
                depth -= 1
            i += 1
        body = registry_content[start_idx:i-1]
        pos = i
        
        route_match = re.search(r"routePath:\s*['\"]([^'\"]+)['\"]", body)
        route_path = route_match.group(1) if route_match else ""
        
        interpolations = re.findall(r'\${(.*?)}', route_path)
        for interp in interpolations:
            if interp in route_mappings:
                route_path = route_path.replace(f"${{{interp}}}", route_mappings[interp])
                
        roles_match = re.search(r"allowedRoles:\s*\[(.*?)\]", body)
        allowed_roles = []
        if roles_match:
            roles_str = roles_match.group(1)
            allowed_roles = [r.strip("'\" ") for r in roles_str.split(',') if r.strip()]
            
        screens[screen_id] = {
            "id": screen_id,
            "routePath": route_path,
            "allowedRoles": allowed_roles
        }

    # 3. Connect to DB and update roles post_login_route
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    # Let's also fix premium_concierge_dashboard and vip_manager_dashboard app_id to 12 (support app) in screens table!
    cur.execute("""
        UPDATE screens
        SET app_id = 12
        WHERE screen_code IN ('premium_concierge_dashboard', 'vip_manager_dashboard');
    """)
    print("Ensured premium_concierge_dashboard and vip_manager_dashboard screens have App ID = 12 (Support).")

    db_roles = cur.execute("SELECT id, role_code, post_login_route FROM roles").fetchall()
    
    updates_count = 0
    for row in db_roles:
        role_code = row["role_code"]
        db_route = row["post_login_route"]
        
        # Re-compute route using get_dashboard_route_for_role
        p_role = from_name(role_code)
        target_route = "/dynamic/clinicalDashboard"
        
        if p_role != "guest" and p_role != "unknown":
            role_upper = p_role.upper()
            found = False
            for screen_id, s in screens.items():
                if s["id"].endswith('_DASHBOARD') and (role_upper in s["allowedRoles"]):
                    target_route = s["routePath"]
                    found = True
                    break
            
            if not found:
                r = role_code.lower().replace(' ', '_').replace('/', '_')
                # Fallback mappings in getDashboardRouteForRole
                if r == 'ceo' or 'founder' in r:
                    target_route = '/offices/corporate/roles/ceo/dashboard'
                elif 'shareholder' in r:
                    target_route = '/offices/corporate/roles/shareholder/dashboard'
                elif r == 'coo': target_route = '/offices/corporate/roles/coo/dashboard'
                elif r == 'cfo': target_route = '/offices/corporate/roles/cfo/dashboard'
                elif r == 'cto': target_route = '/offices/corporate/roles/cto/dashboard'
                elif 'legal' in r: target_route = '/offices/corporate/roles/legal/dashboard'
                elif 'ciso' in r: target_route = '/offices/corporate/roles/ciso/dashboard'
                elif 'compliance_manager' in r:
                    target_route = '/offices/corporate/roles/compliance_manager/dashboard'
                elif 'head_of_bus_dev' in r:
                    target_route = '/offices/corporate/roles/head_of_bus_dev/dashboard'
                elif 'head_of_marketing' in r:
                    target_route = '/offices/corporate/roles/head_of_marketing/dashboard'
                elif 'training_director' in r:
                    target_route = '/offices/corporate/roles/training_director/dashboard'
                elif 'finance_director' in r:
                    target_route = '/offices/corporate/roles/finance_director/dashboard'
                elif 'regional_manager_ontario' in r:
                    target_route = '/offices/business_development/roles/regional_manager_ontario/dashboard'
                elif 'regional_manager_usa' in r:
                    target_route = '/offices/business_development/roles/regional_manager_usa/dashboard'
                elif 'franchise_sales_manager' in r:
                    target_route = '/offices/business_development/roles/franchise_sales_manager/dashboard'
                elif 'partnership_manager' in r:
                    target_route = '/offices/business_development/roles/partnership_manager/dashboard'
                elif 'territory_expansion_manager' in r:
                    target_route = '/offices/business_development/roles/territory_expansion_manager/dashboard'
                elif 'general_manager' in r:
                    target_route = '/offices/business_development/roles/general_manager/dashboard'
                elif 'franchise_owner' in r or 'owner' in r:
                    target_route = '/offices/franchise/roles/franchise_owner/dashboard'
                elif 'operations_manager' in r:
                    target_route = '/offices/franchise/roles/operations_manager/dashboard'
                elif 'scheduler' in r or 'coordinator' in r:
                    target_route = '/offices/franchise/roles/scheduler/dashboard'
                elif 'billing_admin' in r or 'billing' in r:
                    target_route = '/offices/franchise/roles/billing_admin/dashboard'
                elif 'hr_manager' in r or 'hr_hiring' in r:
                    target_route = '/offices/franchise/roles/hr_hiring/dashboard'
                elif 'customer_support' in r or 'support' in r:
                    target_route = '/offices/support/roles/customer_support/dashboard'
                elif 'intake' in r:
                    target_route = '/offices/support/roles/intake_coordinator/dashboard'
                elif 'quality_assurance' in r or 'qa_manager' in r:
                    target_route = '/offices/support/roles/quality_assurance/dashboard'
                elif 'training_coordinator' in r:
                    target_route = '/offices/support/roles/training_coordinator/dashboard'
                elif 'receptionist' in r:
                    target_route = '/dynamic/receptionistDashboard'
                elif 'volunteer_coordinator' in r:
                    target_route = '/offices/corporate/roles/volunteer_coordinator/dashboard'
                elif 'scrum_master' in r:
                    target_route = '/offices/system/roles/scrum_master/dashboard'
                elif 'guest' in r:
                    target_route = '/offices/system/roles/guest/dashboard'
                elif 'local_marketing' in r:
                    target_route = '/offices/marketing/roles/local_marketing_manager/dashboard'
                elif 'outreach' in r:
                    target_route = '/offices/marketing/roles/community_outreach/dashboard'
                elif 'territory_sales' in r:
                    target_route = '/offices/marketing/roles/territory_sales_manager/dashboard'
                elif 'clinical_director' in r:
                    target_route = '/offices/clinical/roles/clinical_director/dashboard'
                elif r == 'psw':
                    target_route = '/offices/clinical/roles/psw/dashboard'
                elif r == 'chiropractor':
                    target_route = '/offices/clinical/roles/chiropractor/dashboard'
                elif r == 'physio' or r == 'physiotherapist':
                    target_route = '/offices/clinical/roles/physiotherapist/dashboard'
                elif r == 'rmt':
                    target_route = '/offices/clinical/roles/rmt/dashboard'
                elif r == 'social_worker':
                    target_route = '/offices/clinical/roles/social_worker/dashboard'
                elif r == 'therapist':
                    target_route = '/offices/clinical/roles/therapist/dashboard'
                elif r == 'intake':
                    target_route = '/offices/clinical/roles/intake_coordinator/dashboard'
                elif r == 'caregiver':
                    target_route = '/offices/clinical/roles/caregiver/dashboard'
                elif r == 'rn':
                    target_route = '/offices/clinical/roles/rn/dashboard'
                elif r == 'rpn':
                    target_route = '/offices/clinical/roles/rpn/dashboard'
                elif 'clinical' in r:
                    target_route = '/dynamic/clinicalDashboard'
                elif r == 'client':
                    target_route = '/offices/client/roles/client/dashboard'
                elif 'family' in r:
                    target_route = '/offices/client/roles/family_member/dashboard'
                elif r == 'admin':
                    target_route = '/offices/franchise/roles/billing_admin/dashboard'
        else:
            r = role_code.lower().replace(' ', '_').replace('/', '_')
            if 'guest' in r:
                target_route = '/offices/system/roles/guest/dashboard'
            else:
                target_route = '/dynamic/clinicalDashboard'

        # Special cases or overrides based on getDashboardRouteForRole Dart implementation:
        # e.g., if guest falls back to guestDashboard, which is /offices/system/roles/guest/dashboard
        if p_role == "guest":
            target_route = '/offices/system/roles/guest/dashboard'
        elif p_role == "familyMember":
            target_route = '/offices/client/roles/family_member/dashboard'
        elif p_role == "client":
            target_route = '/offices/client/roles/client/dashboard'

        if db_route != target_route:
            cur.execute("UPDATE roles SET post_login_route = ? WHERE id = ?", (target_route, row["id"]))
            print(f"Aligned role '{role_code}': DB route '{db_route}' -> Aligned target '{target_route}'")
            updates_count += 1

    conn.commit()
    conn.close()
    print(f"Successfully aligned {updates_count} roles.")

if __name__ == '__main__':
    main()
