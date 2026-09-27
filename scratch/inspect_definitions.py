import sqlite3
import os
import re

# Connect to DB
conn = sqlite3.connect('.agents/governance/governance.db')
conn.row_factory = sqlite3.Row
cur = conn.cursor()

# Get all roles from DB
db_roles = cur.execute("""
    SELECT role_code, primary_app_code, post_login_route 
    FROM roles
""").fetchall()

# Map db_app_code to local app folders
app_folder_map = {
    'clinic': 'primecare_clinic',
    'client': 'primecare_client',
    'support': 'primecare_support',
    'corporate': 'primecare_corporate',
    'franchise': 'primecare_franchise',
    'marketing': 'primecare_marketing',
    'business_development': 'primecare_business_development',
    'governance': 'primecare_governance',
}

# Read roleDefinitions from all GoRouter files in apps
# E.g. apps/primecare_clinic/lib/core/routing/clinic_routes.dart
# apps/primecare_support/lib/core/routing/support_routes.dart
# apps/primecare_client/lib/core/routing/client_routes.dart
# apps/primecare_corporate/lib/core/routing/corporate_routes.dart
# apps/primecare_franchise/lib/core/routing/franchise_routes.dart
# apps/primecare_marketing/lib/core/routing/marketing_routes.dart
# apps/primecare_business_development/lib/core/routing/business_development_routes.dart
# apps/primecare_governance/lib/core/governance/route_registry.dart

app_role_defs = {}

def extract_role_definitions(file_path):
    if not os.path.exists(file_path):
        return []
    with open(file_path, encoding='utf-8') as f:
        content = f.read()
    
    # We want to find PlatformRoleDefinition(...) blocks
    # E.g. PlatformRoleDefinition(role: PlatformRole.xxx, dashboardRoute: xxx)
    defs = []
    # Match: PlatformRoleDefinition( role: PlatformRole.xxx, dashboardRoute: ... )
    matches = re.finditer(r'PlatformRoleDefinition\(\s*role:\s*PlatformRole\.(\w+),\s*dashboardRoute:\s*(.*?),\s*modules:', content, re.DOTALL)
    for m in matches:
         role_enum = m.group(1)
         route_expr = m.group(2).strip()
         defs.append({'role_enum': role_enum, 'route_expr': route_expr})
    return defs

routes_files = {
    'clinic': 'apps/primecare_clinic/lib/core/routing/clinic_routes.dart',
    'client': 'apps/primecare_client/lib/core/routing/client_routes.dart',
    'support': 'apps/primecare_support/lib/core/routing/support_routes.dart',
    'corporate': 'apps/primecare_corporate/lib/core/routing/corporate_routes.dart',
    'franchise': 'apps/primecare_franchise/lib/core/routing/franchise_routes.dart',
    'marketing': 'apps/primecare_marketing/lib/core/routing/marketing_routes.dart',
    'business_development': 'apps/primecare_business_development/lib/core/routing/business_development_routes.dart',
    'governance': 'apps/primecare_governance/lib/core/governance/route_registry.dart',
}

# Also read common routes to resolve string constants
common_routes_content = open('packages/flutter_core/lib/routes/groups/common_routes.dart', encoding='utf-8').read()
clinical_routes_content = open('packages/flutter_core/lib/routes/groups/clinical_routes.dart', encoding='utf-8').read()
corporate_routes_content = open('packages/flutter_core/lib/routes/groups/corporate_routes.dart', encoding='utf-8').read()
franchise_routes_content = open('packages/flutter_core/lib/routes/groups/franchise_routes.dart', encoding='utf-8').read()
client_routes_content = open('packages/flutter_core/lib/routes/groups/client_routes.dart', encoding='utf-8').read()
support_routes_content = open('packages/flutter_core/lib/routes/groups/support_routes.dart', encoding='utf-8').read()

all_routes_text = (
    common_routes_content + "\n" +
    clinical_routes_content + "\n" +
    corporate_routes_content + "\n" +
    franchise_routes_content + "\n" +
    client_routes_content + "\n" +
    support_routes_content
)

def resolve_route_expr(expr):
    # E.g. CommonRoutes.clinicDashboard -> find value of clinicDashboard in all_routes_text
    # static const String clinicDashboard = '...';
    expr_clean = expr.split('.')[-1]
    match = re.search(fr'static const String {expr_clean}\s*=\s*[\'"](.*?)[\'"]', all_routes_text)
    if match:
        return match.group(1)
    if expr.startswith("'") or expr.startswith('"'):
        return expr.strip("'\"")
    return expr

print("=== SCANNED DART APP DEFINITIONS ===")
for app, path in routes_files.items():
    defs = extract_role_definitions(path)
    app_role_defs[app] = defs
    print(f"App '{app}': found {len(defs)} role definitions in {path}")

print("\n=== ANALYZING MISMATCHES ===")
missing_roles = []
mismatch_routes = []

# Map role_code to PlatformRole enum name
def role_code_to_enum(code):
    # Convert snake_case to camelCase
    # E.g. social_worker -> socialWorker
    # GM -> gm
    # Regional_manager_usa -> regionalManagerUsa
    parts = code.lower().split('_')
    enum_name = parts[0] + "".join(p.capitalize() for p in parts[1:])
    # Special cases
    special = {
        'qa': 'qualityAssurance',
        'physio': 'physiotherapist',
        'cns': 'cns',
        'rmt': 'rmt',
        'psw': 'psw',
        'rn': 'rn',
        'rpn': 'rpn',
        'lpn': 'lpn',
        'np': 'np',
        'hsw': 'hsw',
        'ceo': 'ceo',
        'coo': 'coo',
        'cfo': 'cfo',
        'cto': 'cto',
        'ciso': 'ciso',
        'gm': 'generalManager',
        'hrhiring': 'hrHiring',
    }
    return special.get(code, enum_name)

for db_role in db_roles:
    role_code = db_role['role_code']
    app_code = db_role['primary_app_code']
    db_route = db_role['post_login_route']
    
    if app_code not in app_role_defs:
        print(f"Warning: App code '{app_code}' not supported by analyzer.")
        continue
        
    defs = app_role_defs[app_code]
    expected_enum = role_code_to_enum(role_code)
    
    # Find matching definition
    match_def = None
    for d in defs:
        if d['role_enum'].lower() == expected_enum.lower():
            match_def = d
            break
            
    if not match_def:
        missing_roles.append({
            'role_code': role_code,
            'app_code': app_code,
            'expected_enum': expected_enum,
            'db_route': db_route
        })
    else:
        resolved_route = resolve_route_expr(match_def['route_expr'])
        if resolved_route != db_route:
            mismatch_routes.append({
                'role_code': role_code,
                'app_code': app_code,
                'db_route': db_route,
                'app_route': resolved_route
            })

print("\n--- MISSING ROLES FROM APP DEFINITIONS ({}) ---".format(len(missing_roles)))
for r in missing_roles:
    print(f"Role '{r['role_code']}' mapped to '{r['app_code']}' (expected enum: {r['expected_enum']}) is missing from its GoRouter definitions list!")

print("\n--- MISMATCHED DASHBOARD ROUTES ({}) ---".format(len(mismatch_routes)))
for r in mismatch_routes:
    print(f"Role '{r['role_code']}' in app '{r['app_code']}': DB has '{r['db_route']}' but App Code has '{r['app_route']}'")

conn.close()
