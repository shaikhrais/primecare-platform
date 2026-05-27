import os
import re

SCREENS_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "packages", "primecare_ui", "lib", "src", "screens"))

def fix_semantics_and_keys(file_path):
    with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()

    # 1. Deduplicate consecutive duplicate key lines
    new_lines = []
    prev_line = None
    dup_keys_fixed = 0
    
    for line in lines:
        stripped = line.strip()
        if prev_line and "key: const Key(" in stripped and "key: const Key(" in prev_line.strip():
            # Check if they are the same key or just duplicate key definitions
            if stripped == prev_line.strip():
                dup_keys_fixed += 1
                continue # Skip the duplicate line!
        new_lines.append(line)
        prev_line = line

    content = "".join(new_lines)
    
    # 2. Fix the unclosed Semantics brackets targeting the end of buildScreen method
    # The signature we look for is exactly "),\n    );\n  }" or "),\r\n    );\r\n  }"
    # We first find where buildScreen starts to restrict our searches
    build_screen_idx = content.find("Widget buildScreen(")
    brackets_fixed = 0
    
    if build_screen_idx != -1 and "body: Semantics(" in content:
        # Check if it is already fixed
        # If the file already has "),\\n    ),\\n    );" or similar inside buildScreen, we skip it
        # We can find the first Scaffold return closing brackets following buildScreen
        # Scaffold return closing brackets is represented by "),\n    );\n  }" or "),\r\n    );\r\n  }"
        
        # Search for the closing signature after buildScreen
        search_content = content[build_screen_idx:]
        
        # We look for "),\r\n    );\r\n  }" or "),\n    );\n  }"
        r_match = re.search(r"\),\r\n\s*;\r\n\s*}", search_content)
        # Wait, Scaffold return is ");\n  }"
        # Let's search for "),\r\n    );\r\n  }"
        
        modified = False
        if "),\r\n    );\r\n  }" in search_content:
            # Check that we haven't already fixed it (e.g. check for three closing brackets)
            # If "),\r\n    ),\r\n    );\r\n  }" is not present, let's fix it
            if "),\r\n    ),\r\n    );\r\n  }" not in search_content:
                idx = content.find("),\r\n    );\r\n  }", build_screen_idx)
                if idx != -1:
                    content = content[:idx] + "),\r\n    ),\r\n    );\r\n  }" + content[idx + len("),\r\n    );\r\n  }"):]
                    modified = True
                    brackets_fixed = 1
        elif "),\n    );\n  }" in search_content:
            if "),\n    ),\n    );\n  }" not in search_content:
                idx = content.find("),\n    );\n  }", build_screen_idx)
                if idx != -1:
                    content = content[:idx] + "),\n    ),\n    );\n  }" + content[idx + len("),\n    );\n  }"):]
                    modified = True
                    brackets_fixed = 1
                    
        # Let's handle generic spaces/indents in closing Scaffold return if indentation differed
        if not modified:
            # Let's check for any general signature like:
            #       ),\n      );\n    }
            # We can use regex to match exactly:
            # ),\n    [ ]*);\n  }
            match = re.search(r"\),\s*\n(\s*);\r?\n\s*}", search_content)
            if match:
                indent = match.group(1)
                full_sig = match.group(0)
                # Ensure we don't already have three closing brackets
                # If there are only two, we insert the extra ),
                if ")," not in indent:
                    # Let's find the exact index in content
                    rel_idx = match.start()
                    idx = build_screen_idx + rel_idx
                    # The matching signature is closed with "),\n    );\n  }"
                    # Let's replace it with "),\n    ),\n    );\n  }"
                    # Let's reconstruct it cleanly
                    linesep = "\r\n" if "\r\n" in full_sig else "\n"
                    replacement = f"),{linesep}{indent}),{linesep}{indent};{linesep}  }}"
                    content = content[:idx] + replacement + content[idx + len(full_sig):]
                    modified = True
                    brackets_fixed = 1

    if dup_keys_fixed > 0 or brackets_fixed > 0:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(content)
        return True, dup_keys_fixed, brackets_fixed
        
    return False, 0, 0

def main():
    print("==============================================================")
    print("FIXING ALL SCREEN SYNTAX ISSUES (SEMANTICS BRACKETS & KEYS)")
    print("==============================================================")
    
    if not os.path.exists(SCREENS_DIR):
        print(f"Error: Screens directory not found at {SCREENS_DIR}")
        return

    fixed_files = 0
    total_dup_keys = 0
    total_brackets = 0
    scanned_count = 0

    for root, dirs, files in os.walk(SCREENS_DIR):
        for file in files:
            if not file.endswith(".dart"):
                continue
            
            scanned_count += 1
            file_path = os.path.join(root, file)
            
            modified, dup_keys, brackets = fix_semantics_and_keys(file_path)
            if modified:
                fixed_files += 1
                total_dup_keys += dup_keys
                total_brackets += brackets

    print(f"Scanned {scanned_count} files.")
    print(f"Fixed {fixed_files} files in total:")
    print(f"  - Fixed unclosed Semantics brackets: {total_brackets} files")
    print(f"  - Removed duplicate key attributes: {total_dup_keys} lines")

if __name__ == "__main__":
    main()
