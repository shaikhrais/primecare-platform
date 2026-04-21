import re
import os

with open('errors6.txt', 'r', encoding='utf-16') as f:
    analyzer_output = f.readlines()

changes_made = 0
file_changes = {}

for line in analyzer_output:
    match = re.search(r'error - (.*?):(\d+):(\d+) - .*?type \'([^\']+)\'.*', line)
    if not match:
        match = re.search(r'info - (.*?):(\d+):(\d+) - Method invocation.*', line)
        if match:
            # We can't easily auto-fix 'avoid_dynamic_calls' without knowing the expected type
            continue
            
    if match:
        filepath, line_num, col_num, expected_type = match.groups()
        line_num = int(line_num) - 1
        filepath = filepath.strip()
        
        if filepath not in file_changes:
            if not os.path.exists(filepath):
                continue
            with open(filepath, 'r', encoding='utf-8') as f:
                file_changes[filepath] = f.read().split('\n')
                
        lines = file_changes[filepath]
        target_line = lines[line_num]
        original_line = target_line
        
        # Heuristics for the known types of errors
        if 'argument_type_not_assignable' in line or 'invalid_assignment' in line:
            cast_type = expected_type
            if not cast_type.endswith('?'):
                cast_type += '?'
                
            # Pattern 1: (data['logs'] as dynamic) ?? []
            target_line = re.sub(r'\(?([_a-zA-Z0-9!?\[\]\']+)\s+as\s+dynamic\)?', r'(\1 as ' + cast_type + ')', target_line)
            
            # Pattern 2: json.decode(...)
            target_line = re.sub(r'(json\.decode\([^)]+\))', r'(\1 as ' + expected_type + ')', target_line)
            
            # Pattern 3: general raw lookup that is falling back node['key'] ?? fallback
            # We must carefully not break valid syntax.
            target_line = re.sub(r'([_a-zA-Z0-9!]+\[.*?\](?:\?\[.*?\])?)\s*\?\?', r'(\1 as ' + cast_type + r') ??', target_line)
            
            # Pattern 4: A raw lookup passed directly e.g. title: data['title'],
            # We check if there's a lookup followed by a comma
            # title: _carePlan!['diagnoses'] 
            target_line = re.sub(r':\s*([_a-zA-Z0-9!]+\[.*?\](?:\?\[.*?\])?),', r': (\1 as ' + expected_type + '),', target_line)

        if target_line != original_line:
            lines[line_num] = target_line
            changes_made += 1

for filepath, lines in file_changes.items():
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
        
print(f"Made {changes_made} auto-cast modifications.")
