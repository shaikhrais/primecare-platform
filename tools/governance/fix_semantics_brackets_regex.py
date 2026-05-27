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
        indent_body = match.group(1)
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
        
        if fixed_seq in content[match_start_idx - 50: match_start_idx + len(full_match) + 50]:
            return False

        # We need to end it with:
        #     ),
        #   ),
        # );
        # E.g.
        #       ), // closes child widget
        #     ), // closes Semantics widget
        #   ); // closes Scaffold
        # Indent body is indent of child widget (usually 6 spaces)
        # Indent Semantics is indent of Semantics (usually 4 spaces)
        # Indent Scaffold is indent of Scaffold (usually 2 spaces? No, Scaffold is inside return Scaffold( which is indented 4 spaces)
        # Wait, let's look at the original indent:
        # return Scaffold( has 4 spaces of indentation.
        # So Scaffold closes with 4 spaces of indentation: `    );`.
        # So Semantics closes with 4 spaces of indentation: `    ),`.
        # So the child widget closes with 6 spaces of indentation: `      ),`.
        # So the sequence should be:
        #       ),
        #     ),
        #     );
        #   }
        replacement = f"),{linesep}    ),{linesep}    );"
        
        # We replace the sequence starting from the first ), inside the match
        idx = build_screen_idx + match.start()
        bracket_offset = full_match.find("),")
        if bracket_offset != -1:
            idx += bracket_offset
            content = content[:idx] + replacement + linesep + "  }"
            
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(content)
            return True

    return False

def main():
    print("==============================================================")
    print("FIXING ALL REMAINING UNCLOSED SEMANTICS BRACKETS VIA REGEX")
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
    print(f"Successfully fixed unclosed Semantics brackets in {fixed_count} screen files!")

if __name__ == "__main__":
    main()
