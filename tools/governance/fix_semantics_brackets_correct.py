import os
import re

SCREENS_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "packages", "primecare_ui", "lib", "src", "screens"))

def fix_semantics_brackets(file_path):
    with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    build_screen_idx = content.find("Widget buildScreen(")
    if build_screen_idx == -1 or "body: Semantics(" not in content:
        return False

    search_content = content[build_screen_idx:]
    
    # Precise regex to match the Scaffold closing return of the buildScreen method:
    #       ),
    #     );
    #   }
    match = re.search(r"(\s*)\),\s*\r?\n {4}\);\s*\r?\n {2}}", search_content)
    
    if match:
        full_match = match.group(0)
        linesep = "\r\n" if "\r\n" in full_match else "\n"
        
        # If the file already contains the fixed sequence, skip it
        # The fixed sequence would look like:
        #       ),
        #     ),
        #     );
        #   }
        fixed_seq = f"),{linesep}    ),{linesep}    );"
        match_start_idx = build_screen_idx + match.start()
        
        # Let's inspect 50 characters before/after to check if it's already fixed
        surrounding = content[max(0, match_start_idx - 50): min(len(content), match_start_idx + len(full_match) + 50)]
        if fixed_seq in surrounding:
            return False

        # We want to replace the full match with the corrected bracket nesting
        replacement = f"),{linesep}    ),{linesep}    );{linesep}  }}"
        
        # Construct new content by inserting replacement between prefix and suffix
        prefix = content[:match_start_idx]
        suffix = content[match_start_idx + len(full_match):]
        new_content = prefix + replacement + suffix
        
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        return True

    return False

def main():
    print("==============================================================")
    print("FIXING ALL UNCLOSED SEMANTICS BRACKETS WITHOUT TRUNCATING")
    print("==============================================================")
    
    if not os.path.exists(SCREENS_DIR):
        print(f"Error: Screens directory not found at {SCREENS_DIR}")
        return

    fixed_count = 0
    scanned_count = 0

    for root, dirs, files in os.walk(SCREENS_DIR):
        for file in files:
            if not file.endswith(".dart"):
                continue
            
            scanned_count += 1
            file_path = os.path.join(root, file)
            
            if fix_semantics_brackets(file_path):
                fixed_count += 1

    print(f"Scanned {scanned_count} files.")
    print(f"Successfully fixed unclosed Semantics brackets in {fixed_count} screen files without truncation!")

if __name__ == "__main__":
    main()
