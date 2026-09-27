import os
import re

PROJECT_ROOT = r"c:\Users\Admin2\Documents\GitHub\primecare-platform"

def find_matching_bracket(text, start_index):
    count = 0
    for i in range(start_index, len(text)):
        if text[i] == '(':
            count += 1
        elif text[i] == ')':
            count -= 1
            if count == 0:
                return i
    return -1

def fix_file(file_path):
    with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
        code = f.read()

    original_code = code
    basename = os.path.basename(file_path)
    screen_code = basename.replace(".dart", "").replace("_screen", "").replace("_view", "").replace("_", "").lower()
    
    # Pattern 1: title: Text(key: const Key('...-title'), ...)
    title_text_matches = list(re.finditer(r"title:\s*(?:const\s+)?Text\(", code))
    for match in reversed(title_text_matches):
        start_idx = match.start()
        title_prop_len = len(re.search(r"title:\s*", code[start_idx:]).group(0))
        widget_start = start_idx + title_prop_len
        
        # Find matching bracket for Text(...)
        text_open_bracket = widget_start + len(re.search(r"(?:const\s+)?Text\(", code[widget_start:]).group(0)) - 1
        text_end = find_matching_bracket(code, text_open_bracket)
        
        if text_end != -1:
            text_widget_body = code[widget_start:text_end + 1]
            
            # Check if this Text widget has a key indicating it's a testing title
            key_match = re.search(r"key:\s*(?:const\s+)?Key\(['\"]([^'\"]+)['\"]\)", text_widget_body)
            if key_match:
                key_val = key_match.group(1)
                robust_title = f"Semantics(label: 'data-cy:{key_val}', container: true, child: Container(child: {text_widget_body}))"
                code = code[:widget_start] + robust_title + code[text_end + 1:]
                print(f"[{basename}] Wrapped Text title key '{key_val}' in robust semantics.")
            else:
                robust_title = f"Semantics(label: 'data-cy:{screen_code}-title', container: true, child: Container(child: {text_widget_body}))"
                code = code[:widget_start] + robust_title + code[text_end + 1:]
                print(f"[{basename}] Wrapped keyless Text title in robust semantics label 'data-cy:{screen_code}-title'.")

    # Pattern 2: title: Semantics(label: 'data-cy:...', child: Text(...))
    title_semantics_matches = list(re.finditer(r"title:\s*Semantics\(", code))
    for match in reversed(title_semantics_matches):
        start_idx = match.start()
        title_prop_len = len(re.search(r"title:\s*", code[start_idx:]).group(0))
        widget_start = start_idx + title_prop_len
        
        # Find matching bracket for Semantics(...)
        semantics_end = find_matching_bracket(code, widget_start + 9)
        
        if semantics_end != -1:
            semantics_body = code[widget_start:semantics_end + 1]
            
            # Check if this Semantics widget has a label and child Text
            label_match = re.search(r"label:\s*['\"]([^'\"]+)['\"]", semantics_body)
            child_text_match = re.search(r"child:\s*(?:const\s+)?Text\(", semantics_body)
            
            if label_match and child_text_match:
                label_val = label_match.group(1)
                
                # Check if it already has container: true and Container layout parent
                if "container: true" not in semantics_body or "Container(" not in semantics_body:
                    # Extract the Text widget itself
                    text_start = widget_start + child_text_match.start() + 6
                    text_open_bracket = text_start + len(re.search(r"(?:const\s+)?Text\(", code[text_start:]).group(0)) - 1
                    text_end = find_matching_bracket(code, text_open_bracket)
                    
                    if text_end != -1:
                        text_widget = code[text_start:text_end + 1]
                        robust_semantics = f"Semantics(label: '{label_val}', container: true, child: Container(child: {text_widget}))"
                        code = code[:widget_start] + robust_semantics + code[semantics_end + 1:]
                        print(f"[{basename}] Upgraded Semantics label '{label_val}' to robust CanvasKit style.")

    if code != original_code:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(code)
        return True
    return False

def main():
    dirs_to_fix = [
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "psw", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "rn", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "physician", "screens"),
        os.path.join(PROJECT_ROOT, "apps", "primecare_clinic", "lib", "features", "generated_screens"),
    ]
    
    fixed_count = 0
    total_count = 0
    
    for folder in dirs_to_fix:
        if os.path.exists(folder):
            for root, _, files in os.walk(folder):
                for file in files:
                    if file.endswith(".dart"):
                        total_count += 1
                        file_path = os.path.join(root, file)
                        if fix_file(file_path):
                            fixed_count += 1
                            
    print(f"\nCompleted! Audited {total_count} files, updated {fixed_count} files with robust title semantics in apps/primecare_clinic.")

if __name__ == '__main__':
    main()
