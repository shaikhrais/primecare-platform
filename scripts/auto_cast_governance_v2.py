import re
import os
from pathlib import Path

# Provide logic to map line content to valid static types dynamically based on expected type in dart analyze

with open('errors5.txt', 'r', encoding='utf-8') as f:
    analyzer_output = f.readlines()

changes_made = 0
file_changes = {}

for line in analyzer_output:
    if 'argument_type_not_assignable' in line or 'invalid_assignment' in line:
        # Example format:  error - packages\factory_system\primecare_ui\lib\src\components\forms\admin\audit_system_logs_form_adapter.dart:78:17 - The argument type 'dynamic' can't be assigned to the parameter type 'List<dynamic>?'.  - argument_type_not_assignable
        match = re.search(r'error - (.*?):(\d+):(\d+) - .*?type \'([^\']+)\'.*', line)
        if match:
            filepath, line_num, col_num, expected_type = match.groups()
            line_num = int(line_num) - 1
            col_num = int(col_num) - 1
            
            # Normalization of paths
            filepath = filepath.strip()
            
            if filepath not in file_changes:
                if not os.path.exists(filepath):
                    continue
                with open(filepath, 'r', encoding='utf-8') as f:
                    file_changes[filepath] = f.read().split('\n')
                    
            lines = file_changes[filepath]
            target_line = lines[line_num]
            original_line = target_line
            
            # Simple heuristic replacement: 
            # If the expected type is String?, String, bool, Map<String, dynamic> etc
            # We look for something like `node?['something'] ?? fallback` or just `node?['something']`
            
            # Detect what to cast. 
            # If line is `final var = data['key'];` -> `final var = data['key'] as Type;`
            # If line is `title: data['title'] ?? 'N/A'` -> `title: (data['title'] as ExpectedType?) ?? 'N/A'`
            
            # Try specific regex for the `??` pattern
            # Pattern: `(some_var['key'](?:\?\[.*?\])*) ??`
            # Group 1: `some_var['key']` 
            # We want to replace it with `(Group 1 as ExpectedType?) ??`
            
            if expected_type.endswith('?'):
                cast_type = expected_type
            else:
                cast_type = expected_type + '?'
                
            # If the expected type is some Iterable
            if 'Iterable' in expected_type or 'List' in expected_type:
                # We often need `as List<dynamic>?`
                cast_type = expected_type if expected_type.endswith('?') else expected_type + '?'

            # Very naive regex: replace the part before `??` with `( ... as type )`
            # E.g., `_carePlan!['client']?['fullName'] ?? 'Unknown'`
            
            # It's safer to use manual regex if it matches
            if '??' in target_line:
                # regex to capture the variable lookup before `??`
                # e.g., `_carePlan!['client']?['fullName'] ??`
                # We find the furthest left space or assignment
                target_line = re.sub(r'([_a-zA-Z0-9!?\[\]\']+)\s*\?\?', r'(\1 as ' + cast_type + r') ??', target_line)
                
            # if the target line has json.decode
            if 'json.decode' in target_line:
                target_line = re.sub(r'(json\.decode\([^)]+\))', r'(\1 as ' + expected_type + r')', target_line)

            if target_line != original_line:
                lines[line_num] = target_line
                changes_made += 1

for filepath, lines in file_changes.items():
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
        
print(f"Made {changes_made} auto-cast modifications.")
