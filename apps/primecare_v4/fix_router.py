import re
import os

analyze_file = 'analyze.txt'
router_file = 'lib/routes/app_router.dart'

with open(router_file, 'r', encoding='utf-8') as f:
    router_lines = f.readlines()
router_content = "".join(router_lines)

# Find all imports and their prefixes
import_pattern = re.compile(r"import\s+['\"]([^'\"]+)['\"][^;]*as\s+([a-zA-Z0-9_]+)\s*;")
prefix_to_file = {}
for match in import_pattern.finditer(router_content):
    package_path = match.group(1)
    prefix = match.group(2)
    
    if package_path.startswith('package:primecare_v4/'):
        package_path = package_path.replace('package:primecare_v4/', 'lib/', 1)
    elif package_path.startswith('../'):
        package_path = package_path.replace('../', 'lib/', 1)
    elif package_path.startswith('./'):
        package_path = package_path.replace('./', 'lib/routes/', 1)
        
    prefix_to_file[prefix] = package_path

print(f"Found {len(prefix_to_file)} mapped imports.")

# Parse analyze.txt
name_error_regex = re.compile(r"error - lib\\routes\\app_router\.dart:(\d+):\d+ - The name '([^']+)' isn't a class")

with open(analyze_file, 'r', encoding='utf-16') as f:
    analyze_lines = f.readlines()

router_changed = False
for line in analyze_lines:
    match = name_error_regex.search(line)
    if match:
        line_num = int(match.group(1))
        bad_name = match.group(2)
        
        router_line = router_lines[line_num - 1]
        prefix_match = re.search(r'([a-zA-Z0-9_]+)\.' + bad_name, router_line)
        if prefix_match:
            prefix = prefix_match.group(1)
            target_path = prefix_to_file.get(prefix)
            
            if target_path and os.path.exists(target_path):
                with open(target_path, 'r', encoding='utf-8') as tf:
                    target_content = tf.read()
                    
                class_match = re.search(r'class\s+([^ ]+)\s+extends', target_content)
                if class_match:
                    correct_name = class_match.group(1)
                    if bad_name != correct_name:
                        router_lines[line_num - 1] = router_line.replace(f"{prefix}.{bad_name}", f"{prefix}.{correct_name}")
                        print(f"Replaced {prefix}.{bad_name} with {prefix}.{correct_name}")
                        router_changed = True
                else:
                    print(f"No class found in {target_path}")
            else:
                print(f"File not found: {target_path} for prefix {prefix}")

if router_changed:
    with open(router_file, 'w', encoding='utf-8') as f:
        f.writelines(router_lines)
    print("Updated app_router.dart")
