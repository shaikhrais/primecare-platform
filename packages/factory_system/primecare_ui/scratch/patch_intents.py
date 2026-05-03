import os
import re
import glob

# 1. Parse BlueprintSeeder to get Blueprint labels
blueprint_labels = {}
blueprint_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\blueprint_seeder.dart"
with open(blueprint_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern for BlueprintRegistry.register
blueprint_blocks = re.findall(r"AuditorBlueprint\(\s*route:\s*'([^']+)',.*?requiredComponents:\s*\[(.*?)\],\s*\)", content, re.DOTALL)
for route, comps_block in blueprint_blocks:
    labels = re.findall(r"label:\s*'([^']+)'", comps_block)
    blueprint_labels[route] = labels

# 2. Parse registries
registries_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\shared\src\registry\domain_registries"
registry_files = glob.glob(os.path.join(registries_dir, "*.dart"))

route_to_labels = {}
for file in registry_files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # We look for registerRoute calls
    # Usually: registerRoute( CorporateRoutes.ceoDashboard, ... componentLabels: ['...'] )
    # But CorporateRoutes.ceoDashboard isn't the literal string. Let's look at get registryJson
    
    # Actually, it's easier to find the `registryJson` block which has:
    # 'ceo_dashboard': { 'path': CorporateRoutes.ceoDashboard, 'form': ... }
    
    # Or just use the hardcoded route mapping for now.
    pass

# Wait, if we just want to satisfy the "16 known structural mismatches", the easiest is to parse the test file or `CorporateRoutes.dart` and get the paths.
# Let's extract the actual string values for routes.
routes_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\shared\src\registry\office_screen_registry.dart" # wait no, CorporateRoutes is in route_paths.dart?

