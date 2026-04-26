import re
import os
import subprocess

def to_snake(text):
    return re.sub(r'[^a-zA-Z0-9]', '_', text).lower().strip('_')

def run_lint():
    result = subprocess.run(['python', '.agents/governance/lint_loose_text.py', '--full-scan'], capture_output=True, text=True)
    return result.stdout

def fix_files():
    output = run_lint()
    lines = output.split('\n')
    
    file_edits = {}
    
    for line in lines:
        if line.startswith('LOOSE TEXT:'):
            parts = line.split(' -> ')
            if len(parts) == 2:
                file_line = parts[0].replace('LOOSE TEXT: ', '').strip()
                text_part = parts[1].strip()
                
                # file_line like: packages\primecare_adapters\lib\src\...\04_A_foo_dashboard_adapter.dart:47
                file_path, line_no = file_line.rsplit(':', 1)
                line_no = int(line_no)
                
                if file_path not in file_edits:
                    file_edits[file_path] = {}
                file_edits[file_path][line_no] = text_part

    for file_path, edits in file_edits.items():
        if not os.path.exists(file_path):
            continue
            
        with open(file_path, 'r', encoding='utf-8') as f:
            content_lines = f.readlines()
            
        # Extract role from file name
        basename = os.path.basename(file_path)
        role_match = re.match(r'04_A_(.+?)_adapter\.dart', basename)
        if role_match:
            role = role_match.group(1).replace('_dashboard', '')
        else:
            role = 'common'
            
        # Role name without underscores for LocaleKeys (e.g. corporategovernance or corporate_governance)
        # In gen_translations.py, it uses whatever is in intent.dart.
        # Let's just use role with underscores, but intent.dart usually has no underscores or camelCase.
        # Wait! If we look at gen_translations.py, it matches dashboards.role.labels.
        # Let's just use role with underscores removed for safety, since gen_translations uses title_case if it doesn't match?
        # Actually, let's keep underscores and see.
        role_clean = role.replace('_', '')
            
        for line_no, text_part in edits.items():
            # text_part is like: title: 'Compliance Score'
            idx = line_no - 1
            if idx < len(content_lines):
                orig_line = content_lines[idx]
                
                # Extract the actual string
                str_match = re.search(r"'(.*?)'", text_part)
                if str_match:
                    raw_str = str_match.group(1)
                    snake_str = to_snake(raw_str)
                    
                    # We will replace the text_part inside the orig_line
                    # Wait, the string might have interpolation?
                    # Assuming basic strings.
                    # replacement = f"title: LocaleKeys.dashboards_{role_clean}_labels_{snake_str}.tr()"
                    
                    # If the line has 	itle: '...', replace it
                    # Just replace the exact text_part string
                    new_val = f"LocaleKeys.dashboards_{role_clean}_labels_{snake_str}.tr()"
                    if 'title:' in text_part:
                         new_part = f"title: {new_val}"
                         content_lines[idx] = orig_line.replace(text_part, new_part)
                    elif 'label:' in text_part:
                         new_part = f"label: {new_val}"
                         content_lines[idx] = orig_line.replace(text_part, new_part)
                    else:
                         content_lines[idx] = orig_line.replace(f"'{raw_str}'", new_val)

        with open(file_path, 'w', encoding='utf-8') as f:
            f.writelines(content_lines)
            
        print(f"Fixed {file_path}")

fix_files()
