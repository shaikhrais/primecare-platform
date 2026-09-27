import os
import re

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
        start_idx = match.start()
        # Let's find the matching ScreenMetadata block.
        # It ends when depth of parentheses goes back to 0.
        depth = 0
        i = content.find('(', start_idx)
        if i == -1:
            continue
        depth = 1
        i += 1
        while i < len(content) and depth > 0:
            if content[i] == '(':
                depth += 1
            elif content[i] == ')':
                depth -= 1
            i += 1
        
        # Check if there is a trailing comma or closing bracket, etc.
        # Usually, the block is: 'ID': ScreenMetadata(...),
        # We capture from start_idx up to i.
        block = content[start_idx:i]
        # Include trailing comma if present
        if i < len(content) and content[i] == ',':
            block += ','
            i += 1
        screens[screen_id] = block.strip()
    return screens

def main():
    plat_screens = parse_registry(PLATFORM_REGISTRY)
    gov_screens = parse_registry(GOV_REGISTRY)
    
    missing_in_platform = set(gov_screens.keys()) - set(plat_screens.keys())
    print(f"Missing in platform: {len(missing_in_platform)}")
    
    if not missing_in_platform:
        print("Nothing to sync.")
        return
        
    plat_content = open(PLATFORM_REGISTRY, encoding='utf-8').read()
    
    # We want to find the closing '  };' of the screens map.
    # The map starts with: 'static final Map<String, ScreenMetadata> screens = {'
    # and ends with '  };' at the end of the map.
    # Let's find the position of the last '};' before the first 'allScreens' getter or similar.
    # Let's locate '  };' right before '  static List<ScreenMetadata> get allScreens'
    target_pattern = '\n  };\n\n  static List<ScreenMetadata> get allScreens'
    idx = plat_content.find(target_pattern)
    if idx == -1:
        # try without newlines
        target_pattern = '};\n\n  static List<ScreenMetadata> get allScreens'
        idx = plat_content.find(target_pattern)
        
    if idx == -1:
        print("Could not find the insertion point in platform_screen_registry.dart!")
        return
        
    # Construct the blocks to insert
    new_blocks = []
    for s_id in sorted(missing_in_platform):
        block = gov_screens[s_id]
        # Format/indent the block. Each line should have an extra 4 spaces or align with others.
        # Let's just indent it properly.
        lines = block.split('\n')
        indented_block = "\n".join("    " + line.strip() for line in lines)
        # Ensure it ends with comma
        if not indented_block.endswith(','):
            indented_block += ','
        new_blocks.append(indented_block)
        
    insert_str = ",\n" + ",\n".join(new_blocks) + "\n"
    
    new_content = plat_content[:idx] + insert_str + plat_content[idx:]
    
    with open(PLATFORM_REGISTRY, "w", encoding="utf-8") as f:
        f.write(new_content)
        
    print(f"Successfully synced {len(missing_in_platform)} screens into platform_screen_registry.dart")

if __name__ == '__main__':
    main()
