import os
import re
import sqlite3
import json

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def parse_route_constants():
    groups_dir = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "routes", "groups")
    constants = {}
    
    # Class names to look for
    class_pattern = re.compile(r"class\s+([a-zA-Z0-9_]+)\s*\{")
    const_pattern = re.compile(r"static\s+const\s+String\s+([a-zA-Z0-9_]+)\s*=\s*['\"](.*?)['\"]\s*;")
    
    for file in os.listdir(groups_dir):
        if not file.endswith(".dart"):
            continue
        path = os.path.join(groups_dir, file)
        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
            
            # Find class name
            class_match = class_pattern.search(content)
            if not class_match:
                continue
            class_name = class_match.group(1)
            
            # Find all constants in class
            matches = const_pattern.findall(content)
            for var_name, val in matches:
                constants[f"{class_name}.{var_name}"] = val
                
    return constants

def extract_primecare_screens(constants_map):
    apps_dir = os.path.join(PROJECT_ROOT, "apps")
    packages_dir = os.path.join(PROJECT_ROOT, "packages")
    
    target_files = []
    for root, dirs, files in os.walk(apps_dir):
        for file in files:
            if file.endswith("routes.dart") or file.endswith("governance_application.dart"):
                target_files.append(os.path.join(root, file))
                
    for root, dirs, files in os.walk(packages_dir):
        for file in files:
            if file.endswith("routes.dart"):
                target_files.append(os.path.join(root, file))
                
    print(f"Found {len(target_files)} routing files to extract PrimeCareScreen instances:")
    for f in target_files:
        print(f" - {f}")
    
    screens_extracted = []
    
    for file_path in target_files:
        rel_path = os.path.relpath(file_path, PROJECT_ROOT).replace("\\", "/")
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
            
            # Use parenthesis matching to extract PrimeCareScreen blocks
            idx = 0
            file_count = 0
            while True:
                idx = content.find("PrimeCareScreen", idx)
                if idx == -1:
                    break
                
                # Check if it is followed by (
                open_paren_idx = content.find("(", idx, idx + 30)
                if open_paren_idx == -1:
                    idx += 15
                    continue
                
                # Extract block
                start = idx
                paren_count = 0
                end = -1
                for i in range(open_paren_idx + 1, len(content)):
                    if content[i] == '(':
                        paren_count += 1
                    elif content[i] == ')':
                        if paren_count == 0:
                            end = i + 1
                            break
                        else:
                            paren_count -= 1
                
                if end != -1:
                    block = content[start:end]
                    idx = end
                    file_count += 1

                    
                    # Parse block
                    title_match = re.search(r"title:\s*['\"](.*?)['\"]", block)
                    route_match = re.search(r"route:\s*([a-zA-Z0-9_\.\'\"\$/\{\}-]+)", block)
                    builder_match = re.search(r"builder:\s*.*?=>\s*(?:const\s+)?([a-zA-Z0-9_]+)\(", block)
                    role_match = re.search(r"requiredRole:\s*PlatformRole\.([a-zA-Z0-9_]+)", block)
                    
                    title = title_match.group(1) if title_match else None
                    route_expr = route_match.group(1) if route_match else None
                    builder_class = builder_match.group(1) if builder_match else None
                    required_role = role_match.group(1) if role_match else None
                    
                    if route_expr:
                        # Clean route expression (remove quotes if literal string)
                        route_val = route_expr.strip("'\"")
                        
                        # Resolve from constants if it matches Class.var
                        if "." in route_val:
                            # Handle string interpolation like '/generated${CorporateRoutes.ceoGrowthPipeline}'
                            interpolation_match = re.search(r"([a-zA-Z0-9_/]+)?\$\{(.*?)\}", route_val)
                            if interpolation_match:
                                prefix = interpolation_match.group(1) or ""
                                const_name = interpolation_match.group(2)
                                resolved_const = constants_map.get(const_name, "")
                                route_val = prefix + resolved_const
                            else:
                                route_val = constants_map.get(route_val, route_val)
                        
                        screens_extracted.append({
                            "title": title,
                            "route_expr": route_expr,
                            "route_val": route_val,
                            "builder_class": builder_class,
                            "required_role": required_role,
                            "file_path": rel_path
                        })
                else:
                    idx += 1
                    
    return screens_extracted

def main():
    constants = parse_route_constants()
    print(f"Loaded {len(constants)} route constants.")
    
    extracted = extract_primecare_screens(constants)
    print(f"Extracted {len(extracted)} PrimeCareScreen instances.")
    
    # Save a JSON file for debugging
    with open(os.path.join(PROJECT_ROOT, "scratch", "extracted_screens.json"), "w", encoding="utf-8") as f:
        json.dump(extracted, f, indent=2)
        
    print("Saved extracted screens to scratch/extracted_screens.json.")

if __name__ == '__main__':
    main()
