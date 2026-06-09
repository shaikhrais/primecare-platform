import os
import re
import json
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def find_class_for_screen(screen_code, content):
    class_pattern = re.compile(r"class\s+([a-zA-Z0-9_]+Screen|[a-zA-Z0-9_]+View|[a-zA-Z0-9_]+)\s+extends")
    classes = class_pattern.findall(content)
    for cls in classes:
        # Clean screen code conversion matching scan_and_align_governance.py
        sc = re.sub(r'(?<!^)(?=[A-Z])', '_', cls).lower()
        if sc == "dynamic_screen_dashboard_view":
            sc = "dynamic_screen_dashboard"
        elif sc == "screen_audit_view":
            sc = "screen_audit"
        elif sc == "screen_audit_screen":
            sc = "audit"
        elif sc == "audit_screen":
            sc = "audit"
        elif sc == "shared_stubs_screen":
            sc = "shared_stubs"
        elif sc == "screen_not_implemented_view":
            sc = "screen_not_implemented"
        else:
            sc = sc.replace("_screen", "").replace("_view", "")
            
        if sc == screen_code:
            return cls
    return None

def process_file_content(content, class_name, description, components, functions):
    escaped_desc = description.replace("'", "\\'").replace("\n", " ")
    
    comp_list = ",\n        ".join(f"'{c}'" for c in components)
    if comp_list:
        comp_list = f"\n        {comp_list},\n      "
    else:
        comp_list = ""
        
    func_list = ",\n        ".join(f"'{f}'" for f in functions)
    if func_list:
        func_list = f"\n        {func_list},\n      "
    else:
        func_list = ""
        
    overrides = f"""
  @override
  String get screenDescription =>
      '{escaped_desc}';

  @override
  List<String> get requiredComponents => const [{comp_list}];

  @override
  List<String> get requiredFunctions => const [{func_list}];
"""

    # We need to find: class class_name extends BaseClass
    class_pattern = rf"\bclass\s+({class_name})\s+extends\s+([a-zA-Z0-9_]+)"
    match = re.search(class_pattern, content)
    if not match:
        return content, False

    base_class = match.group(2)
    class_decl_start = match.start()
    
    # Find next class definition or end of file
    next_class_match = re.search(r"\bclass\s+\w+", content[class_decl_start + len(match.group(0)):])
    if next_class_match:
        class_decl_end = class_decl_start + len(match.group(0)) + next_class_match.start()
    else:
        class_decl_end = len(content)
        
    class_zone = content[class_decl_start:class_decl_end]
    is_stateful = base_class in ("ConsumerStatefulWidget", "StatefulWidget")
    modified_zone = class_zone
    
    if is_stateful:
        # Change stateful widget base class
        modified_zone = re.sub(rf"\bclass\s+{class_name}\s+extends\s+(?:ConsumerStatefulWidget|StatefulWidget)\b", f"class {class_name} extends GovernedConsumerStatefulWidget", modified_zone)
        
        # Now find and modify the State class in the file
        state_class_pattern = rf"\bclass\s+(_?{class_name}State)\s+extends\s+(?:ConsumerState|State)\s*<\s*{class_name}\s*>"
        state_match = re.search(state_class_pattern, content)
        if state_match:
            state_class_name = state_match.group(1)
            state_decl_start = state_match.start()
            next_state_class_match = re.search(r"\bclass\s+\w+", content[state_decl_start + len(state_match.group(0)):])
            if next_state_class_match:
                state_decl_end = state_decl_start + len(state_match.group(0)) + next_state_class_match.start()
            else:
                state_decl_end = len(content)
                
            state_class_zone = content[state_decl_start:state_decl_end]
            
            # Change State base class
            modified_state_zone = re.sub(state_class_pattern, f"class {state_class_name} extends GovernedConsumerState<{class_name}>", state_class_zone)
            
            # Change Widget build(BuildContext context) to buildScreen
            modified_state_zone = re.sub(r"\bWidget\s+build\s*\(\s*BuildContext\s+context\s*\)", "Widget buildScreen(BuildContext context)", modified_state_zone)
            
            # Strip existing getters
            modified_state_zone = re.sub(r"get\s+screenDescription\s+=>\s+.*?;", "", modified_state_zone)
            modified_state_zone = re.sub(r"String\s+get\s+screenDescription\s*\{.*?}", "", modified_state_zone, flags=re.DOTALL)
            modified_state_zone = re.sub(r"get\s+requiredComponents\s+=>\s+.*?;", "", modified_state_zone)
            modified_state_zone = re.sub(r"List<String>\s+get\s+requiredComponents\s*\{.*?}", "", modified_state_zone, flags=re.DOTALL)
            modified_state_zone = re.sub(r"get\s+requiredFunctions\s+=>\s+.*?;", "", modified_state_zone)
            modified_state_zone = re.sub(r"List<String>\s+get\s+requiredFunctions\s*\{.*?}", "", modified_state_zone, flags=re.DOTALL)
            
            # Inject overrides into state class right after the opening brace
            brace_pos = modified_state_zone.find("{")
            if brace_pos != -1:
                modified_state_zone = modified_state_zone[:brace_pos+1] + overrides + modified_state_zone[brace_pos+1:]
                
            content = content[:state_decl_start] + modified_state_zone + content[state_decl_end:]
            # Re-read class declaration positions since content changed length
            match = re.search(class_pattern, content)
            if match:
                class_decl_start = match.start()
                next_class_match = re.search(r"\bclass\s+\w+", content[class_decl_start + len(match.group(0)):])
                if next_class_match:
                    class_decl_end = class_decl_start + len(match.group(0)) + next_class_match.start()
                else:
                    class_decl_end = len(content)
                modified_zone = content[class_decl_start:class_decl_end]
                modified_zone = re.sub(rf"\bclass\s+{class_name}\s+extends\s+(?:ConsumerStatefulWidget|StatefulWidget)\b", f"class {class_name} extends GovernedConsumerStatefulWidget", modified_zone)
            
    else:
        # For stateless/consumer widgets
        if base_class == "ConsumerWidget":
            modified_zone = re.sub(rf"\bclass\s+{class_name}\s+extends\s+ConsumerWidget\b", f"class {class_name} extends GovernedConsumerWidget", modified_zone)
            modified_zone = re.sub(r"\bWidget\s+build\s*\(\s*BuildContext\s+context\s*,\s*WidgetRef\s+ref\s*\)", "Widget buildScreen(BuildContext context, WidgetRef ref)", modified_zone)
        elif base_class == "StatelessWidget":
            modified_zone = re.sub(rf"\bclass\s+{class_name}\s+extends\s+StatelessWidget\b", f"class {class_name} extends GovernedStatelessWidget", modified_zone)
            modified_zone = re.sub(r"\bWidget\s+build\s*\(\s*BuildContext\s+context\s*\)", "Widget buildScreen(BuildContext context)", modified_zone)
        elif base_class == "GovernedConsumerWidget":
            modified_zone = re.sub(r"\bWidget\s+build\s*\(\s*BuildContext\s+context\s*,\s*WidgetRef\s+ref\s*\)", "Widget buildScreen(BuildContext context, WidgetRef ref)", modified_zone)
        elif base_class == "GovernedStatelessWidget":
            modified_zone = re.sub(r"\bWidget\s+build\s*\(\s*BuildContext\s+context\s*\)", "Widget buildScreen(BuildContext context)", modified_zone)
            
        # Strip existing getters
        modified_zone = re.sub(r"get\s+screenDescription\s+=>\s+.*?;", "", modified_zone)
        modified_zone = re.sub(r"String\s+get\s+screenDescription\s*\{.*?}", "", modified_zone, flags=re.DOTALL)
        modified_zone = re.sub(r"get\s+requiredComponents\s+=>\s+.*?;", "", modified_zone)
        modified_zone = re.sub(r"List<String>\s+get\s+requiredComponents\s*\{.*?}", "", modified_zone, flags=re.DOTALL)
        modified_zone = re.sub(r"get\s+requiredFunctions\s+=>\s+.*?;", "", modified_zone)
        modified_zone = re.sub(r"List<String>\s+get\s+requiredFunctions\s*\{.*?}", "", modified_zone, flags=re.DOTALL)
        
        # Inject overrides into widget class right after the opening brace
        brace_pos = modified_zone.find("{")
        if brace_pos != -1:
            modified_zone = modified_zone[:brace_pos+1] + overrides + modified_zone[brace_pos+1:]
            
    content = content[:class_decl_start] + modified_zone + content[class_decl_end:]
    
    # Ensure imports
    if "package:flutter_core/flutter_core.dart" not in content and "package:primecare_ui/primecare_ui.dart" not in content:
        # Prepend import
        first_import = re.search(r"import\s+['\"].*?['\"];", content)
        if first_import:
            content = content.replace(first_import.group(0), first_import.group(0) + "\nimport 'package:flutter_core/flutter_core.dart';")
        else:
            content = "import 'package:flutter_core/flutter_core.dart';\n" + content
            
    return content, True

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: BULK IMPLEMENTATION AUTO-INJECTOR")
    print("==============================================================")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cur = conn.cursor()
    
    # Select screens with valid file paths
    screens = cur.execute("""
        SELECT screen_code, screen_name, actual_file_path, required_components_json, required_functions_json, code_gap_summary 
        FROM screens 
        WHERE actual_file_path IS NOT NULL AND actual_file_path != ''
    """).fetchall()
    
    print(f"Found {len(screens)} screens registered with files in database.")
    
    success_count = 0
    skipped_count = 0
    error_count = 0
    
    for idx, s in enumerate(screens, 1):
        screen_code = s["screen_code"]
        screen_name = s["screen_name"]
        rel_path = s["actual_file_path"]
        
        full_path = os.path.join(PROJECT_ROOT, rel_path)
        if not os.path.exists(full_path):
            skipped_count += 1
            continue
            
        try:
            req_components = json.loads(s["required_components_json"]) if s["required_components_json"] else []
        except Exception:
            req_components = []
            
        try:
            req_functions = json.loads(s["required_functions_json"]) if s["required_functions_json"] else []
        except Exception:
            req_functions = []
            
        description = s["code_gap_summary"] or f"{screen_name} workspace interface."
        
        # Read content
        with open(full_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read()
            
        # Find corresponding class name in file
        class_name = find_class_for_screen(screen_code, content)
        if not class_name:
            # Try finding any screen class in file as fallback
            class_match = re.search(r"class\s+([a-zA-Z0-9_]+Screen|[a-zA-Z0-9_]+View)\s+extends", content)
            if class_match:
                class_name = class_match.group(1)
                
        if not class_name:
            print(f"[{idx}/{len(screens)}] Skipped '{screen_code}': class not found in {rel_path}")
            skipped_count += 1
            continue
            
        try:
            new_content, changed = process_file_content(content, class_name, description, req_components, req_functions)
            if changed:
                with open(full_path, "w", encoding="utf-8") as f:
                    f.write(new_content)
                success_count += 1
            else:
                skipped_count += 1
        except Exception as e:
            print(f"[{idx}/{len(screens)}] Error processing '{screen_code}': {e}")
            error_count += 1
            
    conn.close()
    
    print("\n==============================================================")
    print("BULK IMPLEMENTATION SUMMARY")
    print("==============================================================")
    print(f"Successfully Updated Screens: {success_count}")
    print(f"Skipped Screens: {skipped_count}")
    print(f"Failed Screens: {error_count}")
    print("==============================================================")

if __name__ == "__main__":
    main()
