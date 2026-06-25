import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
REGISTRY_PATH = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "registry", "platform_screen_registry.dart")
ROUTES_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "routes", "groups")

def main():
    # 1. Parse all Route Constants from groups
    route_mappings = {}
    for filename in os.listdir(ROUTES_DIR):
        if filename.endswith('.dart'):
            filepath = os.path.join(ROUTES_DIR, filename)
            content = open(filepath, encoding='utf-8').read()
            class_match = re.search(r'class\s+(\w+)', content)
            if class_match:
                class_name = class_match.group(1)
                constants = re.findall(r'static\s+const\s+String\s+(\w+)\s*=\s*[\'"]([^\'"]+)[\'"]', content)
                for name, val in constants:
                    route_mappings[f"{class_name}.{name}"] = val

    # 2. Parse platform_screen_registry.dart
    registry_content = open(REGISTRY_PATH, encoding='utf-8').read()
    matches = re.finditer(r"'(\w+)'\s*:\s*ScreenMetadata\(", registry_content)
    
    mismatches = []
    for match in matches:
        screen_id = match.group(1)
        start_idx = match.end()
        depth = 1
        i = start_idx
        while i < len(registry_content) and depth > 0:
            if registry_content[i] == '(':
                depth += 1
            elif registry_content[i] == ')':
                depth -= 1
            i += 1
        body = registry_content[start_idx:i-1]
        
        route_match = re.search(r"routePath:\s*['\"]([^'\"]+)['\"]", body)
        route_path = route_match.group(1) if route_match else ""
        
        # Replace interpolated constants in route_path
        interpolations = re.findall(r'\${(.*?)}', route_path)
        for interp in interpolations:
            if interp in route_mappings:
                route_path = route_path.replace(f"${{{interp}}}", route_mappings[interp])
                
        # Let's see if this screen is a dashboard screen, and check if its routePath is aligned with standard routes.
        # We can map the screen ID to standard expected routes.
        expected_route = None
        if screen_id == 'PATIENT_DASHBOARD':
            expected_route = route_mappings.get('ClientRoutes.patientDashboard')
        elif screen_id == 'FAMILYMEMBER_DASHBOARD':
            expected_route = route_mappings.get('ClientRoutes.familyMemberDashboard')
        elif screen_id == 'PORTAL_DASHBOARD':
            expected_route = route_mappings.get('ClientRoutes.patientDashboard') # Patient dashboard is portal dashboard in Client app
        elif screen_id == 'GUEST_DASHBOARD':
            expected_route = route_mappings.get('CommonRoutes.guestDashboard')
        elif screen_id == 'CUSTOMERSUPPORT_DASHBOARD':
            expected_route = route_mappings.get('SupportRoutes.customerSupportDashboard')
            
        if expected_route and route_path != expected_route:
            mismatches.append((screen_id, route_path, expected_route))
            
    print(f"Found {len(mismatches)} mismatches:")
    for m in mismatches:
        print(f"Screen: {m[0]} | Registry Route: {m[1]} | Expected Route: {m[2]}")

if __name__ == '__main__':
    main()
