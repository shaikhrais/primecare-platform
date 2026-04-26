import re
import os
import json

def deep_scan_localization(root_dir):
    # Patterns to match hardcoded strings in common Flutter widgets/properties
    patterns = [
        r"Text\(\s*['\"]([^'\"]+)['\"]\s*",
        r"tooltip:\s*['\"]([^'\"]+)['\"]",
        r"hintText:\s*['\"]([^'\"]+)['\"]",
        r"labelText:\s*['\"]([^'\"]+)['\"]",
        r"title:\s*const\s+Text\(\s*['\"]([^'\"]+)['\"]\s*\)",
        r"subtitle:\s*const\s+Text\(\s*['\"]([^'\"]+)['\"]\s*\)",
    ]
    
    hardcoded_strings = {} # string -> list of (file, line)
    
    for root, _, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.dart'):
                file_path = os.path.join(root, file)
                with open(file_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()
                    for i, line in enumerate(lines):
                        for pattern in patterns:
                            matches = re.findall(pattern, line)
                            for match in matches:
                                # Skip if it looks like a translation key (has dots) or is already .tr()
                                if '.' in match and match.islower():
                                    continue
                                if '.tr()' in line:
                                    continue
                                if match not in hardcoded_strings:
                                    hardcoded_strings[match] = []
                                hardcoded_strings[match].append((file_path, i + 1))
                                
    return hardcoded_strings

if __name__ == "__main__":
    root = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src"
    strings = deep_scan_localization(root)
    
    # Print summary
    print(f"Found {len(strings)} unique hardcoded strings.")
    
    # Save to a scratch file for review
    output_path = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\localization_audit.json"
    # Convert paths to relative for easier reading
    serializable_strings = {k: [os.path.relpath(p, root) + f":{l}" for p, l in v] for k, v in strings.items()}
    
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(serializable_strings, f, indent=2)
    
    print(f"Audit saved to {output_path}")
