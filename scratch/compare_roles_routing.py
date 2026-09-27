import os
import sqlite3
import re

DB_PATH = ".agents/governance/governance.db"

conn = sqlite3.connect(DB_PATH)
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Get all roles from DB
db_roles = cur.execute("""
    SELECT role_code, primary_app_code, post_login_route
    FROM roles
""").fetchall()

print(f"Loaded {len(db_roles)} roles from database.")

# Map app code to the route file path where roleDefinitions are defined
app_route_files = {
    "support": "apps/primecare_support/lib/core/routing/support_routes.dart",
    "business_development": "apps/primecare_business_development/lib/core/routing/business_development_routes.dart",
    "marketing": "apps/primecare_marketing/lib/core/routing/marketing_routes.dart",
    "corporate": "apps/primecare_corporate/lib/core/routing/app_router.dart",
    "franchise": "apps/primecare_franchise/lib/core/routing/franchise_routes.dart",
    "clinic": "apps/primecare_clinic/lib/core/routing/app_router.dart",
    "client": "apps/primecare_client/lib/core/routing/app_router.dart",
    "governance": "apps/primecare_governance/lib/core/governance/route_registry.dart",
}

# Helper to normalize role code to how it appears in Dart enum/camelCase
def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

# Let's inspect each role
unregistered = []
registered = []

for r in db_roles:
    role_code = r["role_code"]
    app_code = r["primary_app_code"]
    post_login_route = r["post_login_route"]
    
    if app_code not in app_route_files:
        print(f"Warning: Unknown app code '{app_code}' for role '{role_code}'")
        continue
        
    route_file = app_route_files[app_code]
    if not os.path.exists(route_file):
        print(f"Warning: Route file '{route_file}' not found for app '{app_code}'")
        continue
        
    with open(route_file, "r", encoding="utf-8") as f:
        content = f.read()
        
    # Standard role enum name in Dart
    camel_role = to_camel_case(role_code)
    
    # Check if this role is in roleDefinitions or registered dynamically
    # Look for: PlatformRole.role_code or PlatformRole.camel_role
    pattern1 = rf"PlatformRole\.{role_code}\b"
    pattern2 = rf"PlatformRole\.{camel_role}\b"
    
    # Special normalization check for roles that are mapped in PlatformRole.fromName:
    # 'superadmin' -> PlatformRole.admin
    # 'physio' -> PlatformRole.physiotherapist
    # 'intake' -> PlatformRole.intakeCoordinator
    # 'compliance' -> PlatformRole.complianceManager
    # 'gm' -> PlatformRole.generalManager
    # 'busdev' -> PlatformRole.headOfBusDev
    # 'marketing' -> PlatformRole.headOfMarketing
    # 'opsmanager' -> PlatformRole.operationsManager
    # 'regionalmanagerusa' -> PlatformRole.regionalManagerUsa
    # 'scrummaster' -> PlatformRole.scrumMaster
    # 'hrhiring' -> PlatformRole.hrHiring
    # 'territoryexpansion' -> PlatformRole.territoryExpansionManager
    # 'territorysales' -> PlatformRole.territorySalesManager
    # 'volunteercoordinator' -> PlatformRole.volunteerCoordinator
    # 'family' -> PlatformRole.familyMember
    # 'training' -> PlatformRole.trainingHub
    # 'dynamic' -> PlatformRole.dynamicScreen
    
    resolved_role = camel_role
    if role_code == "admin":
        resolved_role = "admin" # wait, PlatformRole.admin
    elif role_code == "physio":
        resolved_role = "physiotherapist"
    elif role_code == "intake":
        resolved_role = "intakeCoordinator"
    elif role_code == "compliance":
        resolved_role = "complianceManager"
    elif role_code == "gm":
        resolved_role = "generalManager"
    elif role_code == "bus_dev":
        resolved_role = "headOfBusDev"
    elif role_code == "marketing":
        resolved_role = "headOfMarketing"
    elif role_code == "ops_manager":
        resolved_role = "operationsManager"
    elif role_code == "regional_manager_usa":
        resolved_role = "regionalManagerUsa"
    elif role_code == "scrum_master":
        resolved_role = "scrumMaster"
    elif role_code == "hr_hiring":
        resolved_role = "hrHiring"
    elif role_code == "territory_expansion":
        resolved_role = "territoryExpansionManager"
    elif role_code == "territory_sales":
        resolved_role = "territorySalesManager"
    elif role_code == "volunteer_coordinator":
        resolved_role = "volunteerCoordinator"
    elif role_code == "family":
        resolved_role = "familyMember"
    elif role_code == "training":
        resolved_role = "trainingHub"
    elif role_code == "dynamic":
        resolved_role = "dynamicScreen"
        
    pattern3 = rf"PlatformRole\.{resolved_role}\b"
    
    # For governance app, it dynamically loads everything
    is_registered = False
    if app_code == "governance":
        is_registered = True
    elif re.search(pattern1, content) or re.search(pattern2, content) or re.search(pattern3, content):
        is_registered = True
        
    if is_registered:
        registered.append((role_code, app_code, resolved_role, post_login_route))
    else:
        unregistered.append((role_code, app_code, resolved_role, post_login_route))

print(f"\nRegistered Roles ({len(registered)}):")
for r in registered:
    print(f"  - {r[0]} ({r[1]}) -> resolved: {r[2]} | Route: {r[3]}")

print(f"\nUnregistered Roles ({len(unregistered)}):")
for r in unregistered:
    print(f"  - {r[0]} ({r[1]}) -> resolved: {r[2]} | Route: {r[3]}")

conn.close()
