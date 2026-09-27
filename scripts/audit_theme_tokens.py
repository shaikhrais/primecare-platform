import os
import re

project_root = r'c:\Users\Admin2\Documents\GitHub\primecare-platform'
search_dirs = [
    os.path.join(project_root, 'packages', 'primecare_ui', 'lib', 'src', 'screens'),
    os.path.join(project_root, 'apps')
]

# Regex patterns for hardcoded colors
color_hex_pattern = re.compile(r'Color\(0x[0-9a-fA-F]+\)')
color_material_pattern = re.compile(r'Colors\.[a-zA-Z_]+')

violations = 0
checked_files = 0

print("==================================================")
print("RUNNING DYNAMIC THEME TOKENS COMPLIANCE AUDIT")
print("==================================================")

for search_dir in search_dirs:
    if not os.path.exists(search_dir):
        continue
    for root, dirs, files in os.walk(search_dir):
        for f in files:
            if f.endswith('.dart') and not f.endswith('.g.dart') and 'backup' not in root:
                filepath = os.path.join(root, f)
                checked_files += 1
                try:
                    with open(filepath, 'r', encoding='utf-8', errors='ignore') as file:
                        lines = file.readlines()
                    for idx, line in enumerate(lines):
                        # Skip comment lines
                        if line.strip().startswith('//') or line.strip().startswith('*'):
                            continue
                        
                        # Find hex color hardcoding
                        hex_matches = color_hex_pattern.findall(line)
                        material_matches = color_material_pattern.findall(line)
                        
                        # Skip transparent/black/white defaults if allowed by design tokens
                        allowed_defaults = ['Colors.transparent', 'Colors.white', 'Colors.black']
                        material_matches = [m for m in material_matches if m not in allowed_defaults]
                        
                        if hex_matches or material_matches:
                            rel_path = os.path.relpath(filepath, project_root)
                            print(f"[VIOLATION] {rel_path}:{idx+1} - Hardcoded colors found: {hex_matches + material_matches}")
                            print(f"  Line: {line.strip()}")
                            violations += 1
                except Exception as e:
                    print(f"Error reading {filepath}: {e}")

print("==================================================")
print("THEME COMPLIANCE RESULTS:")
print(f"  Total Files Audited: {checked_files}")
print(f"  Token Violations:    {violations}")
if violations == 0:
    print("  Status: COMPLIANT (All styles use design tokens)")
else:
    print("  Status: NON-COMPLIANT (Fix hardcoded colors to use theme.colors.*)")
print("==================================================")
