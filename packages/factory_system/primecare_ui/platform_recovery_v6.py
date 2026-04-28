import os
import re

def fix_file_v6(path):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Fix the prefix_that mess
    # Replace 'Prefix_that' with '_that'
    content = re.sub(r'\b\w+_that\b', '_that', content)
    
    # 2. De-duplicate definitions
    # This is tricky for classes, but let's try to remove exact duplicate blocks
    # Actually, a safer way is to just find duplicate class names and comment them out.
    class_names = re.findall(r'class (\w+)', content)
    seen_classes = set()
    lines = content.splitlines()
    new_lines = []
    
    in_duplicate = False
    brace_count = 0
    
    for line in lines:
        cls_match = re.search(r'class (\w+)', line)
        if cls_match:
            cls_name = cls_match.group(1)
            if cls_name in seen_classes:
                in_duplicate = True
                brace_count = 0
                new_lines.append(f'// Duplicate definition: {line}')
                if '{' in line: brace_count += line.count('{') - line.count('}')
                continue
            else:
                seen_classes.add(cls_name)
        
        if in_duplicate:
            new_lines.append(f'// {line}')
            brace_count += line.count('{') - line.count('}')
            if brace_count <= 0 and '}' in line:
                in_duplicate = False
            continue
        
        new_lines.append(line)
    
    content = '\n'.join(new_lines)

    # 3. Fix 'vm' undefined in view
    # If we see 'vm.something' and 'vm' is not defined in the method
    # This is hard to fix automatically without knowing the provider.
    
    # 4. Fix 'ref' undefined in view
    # Often happens in sub-widgets.
    
    # 5. Add missing imports
    if 'features_view' in path:
        header = """
import 'package:primecare_ui/src/shared/src/core/registry.dart';
import 'package:primecare_ui/src/components/prime_status_badge.dart';
"""
        if header.strip() not in content:
            content = header + content

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

# Run it
fix_file_v6('lib/src/features/features_controller.dart')
fix_file_v6('lib/src/features/features_model.dart')
fix_file_v6('lib/src/features/features_view.dart')
print("V6 De-duplication Complete")
