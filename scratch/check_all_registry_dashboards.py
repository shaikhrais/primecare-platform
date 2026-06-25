import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
REGISTRY_PATH = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "registry", "platform_screen_registry.dart")
ROUTES_DIR = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "routes", "groups")

def camel_to_snake(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

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
                    # Store without class name too for simple lookup
                    route_mappings[name] = val

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
                
        # If it's a dashboard screen, check standard matching constant
        if screen_id.endswith('_DASHBOARD'):
            # Convert screen ID (e.g. INTAKECOORDINATOR_DASHBOARD) to expected camelCase constant (intakeCoordinatorDashboard)
            base_name = screen_id[:-10].lower() # e.g. intakecoordinator
            # Try to match in route_mappings keys
            expected_route = None
            found_key = None
            for key, val in route_mappings.items():
                if key.lower() == f"{base_name}dashboard":
                    expected_route = val
                    found_key = key
                    break
                    
            if expected_route and route_path != expected_route:
                mismatches.append((screen_id, route_path, expected_route, found_key))
                
    print(f"Found {len(mismatches)} dashboard mismatches:")
    for m in mismatches:
        print(f"Screen: {m[0]} | Registry Route: {m[1]} | Expected Route: {m[2]} (constant: {m[3]})")

if __name__ == '__main__':
    main()
