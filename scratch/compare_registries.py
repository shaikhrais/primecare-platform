import re
import os

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"
PLATFORM_REGISTRY = os.path.join(PROJECT_ROOT, "packages", "flutter_core", "lib", "registry", "platform_screen_registry.dart")
GOV_REGISTRY = os.path.join(PROJECT_ROOT, "apps", "primecare_governance", "lib", "core", "governance", "registries", "core_governance_registry.dart")

def parse_registry(path):
    if not os.path.exists(path):
        return {}
    content = open(path, encoding='utf-8').read()
    matches = re.finditer(r"'(\w+)'\s*:\s*ScreenMetadata\(", content)
    screens = {}
    for match in matches:
        screen_id = match.group(1)
        start_idx = match.end()
        depth = 1
        i = start_idx
        while i < len(content) and depth > 0:
            if content[i] == '(':
                depth += 1
            elif content[i] == ')':
                depth -= 1
            i += 1
        body = content[start_idx:i-1]
        screens[screen_id] = body
    return screens

def main():
    plat_screens = parse_registry(PLATFORM_REGISTRY)
    gov_screens = parse_registry(GOV_REGISTRY)
    
    print(f"Platform Registry screens count: {len(plat_screens)}")
    print(f"Governance Registry screens count: {len(gov_screens)}")
    
    missing_in_platform = set(gov_screens.keys()) - set(plat_screens.keys())
    missing_in_gov = set(plat_screens.keys()) - set(gov_screens.keys())
    
    print(f"\nMissing in Platform Registry ({len(missing_in_platform)}):")
    for s in sorted(missing_in_platform):
        if "DASHBOARD" in s:
            print(f"- {s}")
            
    print(f"\nMissing in Governance Registry ({len(missing_in_gov)}):")
    for s in sorted(missing_in_gov):
        if "DASHBOARD" in s:
            print(f"- {s}")

if __name__ == '__main__':
    main()
