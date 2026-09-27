import os
import re
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GROUPS_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "routes", "groups")

# Step 1: Parse all route constants from groups/
route_constants = {}

for filename in os.listdir(GROUPS_DIR):
    if not filename.endswith(".dart"):
        continue
    filepath = os.path.join(GROUPS_DIR, filename)
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
    
    # Find class name
    class_match = re.search(r"class\s+(\w+)", content)
    if not class_match:
        continue
    class_name = class_match.group(1)
    
    # Find all static const String fields
    # e.g., static const String clientDashboard = '/offices/client/roles/client/dashboard';
    fields = re.findall(r"static\s+const\s+String\s+(\w+)\s*=\s*['\"]([^'\"]+)['\"]", content)
    for field_name, val in fields:
        route_constants[f"{class_name}.{field_name}"] = val

# Add CommonRoutes since it's also imported/used
# Also add any manual overrides if they refer to other classes
print(f"Loaded {len(route_constants)} route constants.")

# Step 2: Define mapping of files and app codes
app_files = {
    "support": os.path.join(PROJECT_ROOT, "apps", "primecare_support", "lib", "core", "routing", "support_routes.dart"),
    "business_development": os.path.join(PROJECT_ROOT, "apps", "primecare_business_development", "lib", "core", "routing", "business_development_routes.dart"),
    "marketing": os.path.join(PROJECT_ROOT, "apps", "primecare_marketing", "lib", "core", "routing", "marketing_routes.dart"),
    "corporate": os.path.join(PROJECT_ROOT, "apps", "primecare_corporate", "lib", "core", "routing", "corporate_routes.dart"),
    "franchise": os.path.join(PROJECT_ROOT, "apps", "primecare_franchise", "lib", "core", "routing", "franchise_routes.dart"),
    "clinic": os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "core", "routing", "clinic_routes.dart"),
    "client": os.path.join(PROJECT_ROOT, "apps", "primecare_client", "lib", "core", "routing", "app_router.dart"),
}

# Normalize camelCase back to snake_case for SQLite comparison
def camel_to_snake(name):
    name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()

app_extracted_roles = {}

for app_code, filepath in app_files.items():
    if not os.path.exists(filepath):
        print(f"Skipping {app_code} as {filepath} does not exist.")
        continue
        
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
        
    # Let's extract PlatformRoleDefinition instances
    # Pattern: PlatformRoleDefinition(\s*role\s*:\s*PlatformRole\.(\w+),\s*dashboardRoute\s*:\s*([^,]+),)
    # We can use a regex that matches PlatformRoleDefinition constructor
    matches = re.finditer(r"PlatformRoleDefinition\s*\(\s*role\s*:\s*PlatformRole\.(\w+),\s*(?:label\s*:\s*[^,]+,\s*)?dashboardRoute\s*:\s*([^,]+),", content)
    
    app_extracted_roles[app_code] = []
    for m in matches:
        role_enum = m.group(1)
        route_expr = m.group(2).strip().strip("'").strip('"')
        
        # Resolve route constant if it's one
        resolved_route = route_expr
        if route_expr in route_constants:
            resolved_route = route_constants[route_expr]
            
        role_code = camel_to_snake(role_enum)
        
        # Mappings back to database names if they mismatch:
        # e.g., generalManager -> gm
        # headOfBusDev -> bus_dev
        # headOfMarketing -> marketing
        # operationsManager -> ops_manager
        # regionalManagerUsa -> regional_manager_usa
        # scrumMaster -> scrum_master
        # hrHiring -> hr_hiring
        # territoryExpansionManager -> territory_expansion
        # territorySalesManager -> territory_sales
        # volunteerCoordinator -> volunteer_coordinator
        # familyMember -> family
        # trainingHub -> training
        # dynamicScreen -> dynamic
        # admin -> admin
        # intakeCoordinator -> intake
        # complianceManager -> compliance
        
        db_role_code = role_code
        if role_enum == "generalManager":
            db_role_code = "gm"
        elif role_enum == "headOfBusDev":
            db_role_code = "bus_dev"
        elif role_enum == "headOfMarketing":
            db_role_code = "marketing"
        elif role_enum == "operationsManager":
            db_role_code = "ops_manager"
        elif role_enum == "regionalManagerUsa":
            db_role_code = "regional_manager_usa"
        elif role_enum == "scrumMaster":
            db_role_code = "scrum_master"
        elif role_enum == "hrHiring":
            db_role_code = "hr_hiring"
        elif role_enum == "territoryExpansionManager":
            db_role_code = "territory_expansion"
        elif role_enum == "territorySalesManager":
            db_role_code = "territory_sales"
        elif role_enum == "volunteerCoordinator":
            db_role_code = "volunteer_coordinator"
        elif role_enum == "familyMember":
            db_role_code = "family"
        elif role_enum == "trainingHub":
            db_role_code = "training"
        elif role_enum == "dynamicScreen":
            db_role_code = "dynamic"
        elif role_enum == "intakeCoordinator":
            db_role_code = "intake"
        elif role_enum == "complianceManager":
            db_role_code = "compliance"
        elif role_enum == "franchiseOwner":
            db_role_code = "owner"
            
        app_extracted_roles[app_code].append({
            "role_enum": role_enum,
            "role_code": db_role_code,
            "route": resolved_route
        })

print("\nExtracted role routing mapping from Dart files:")
for app_code, roles in app_extracted_roles.items():
    print(f"\nApp: {app_code}")
    for r in roles:
        print(f"  Role: {r['role_code']} ({r['role_enum']}) -> Route: {r['route']}")
