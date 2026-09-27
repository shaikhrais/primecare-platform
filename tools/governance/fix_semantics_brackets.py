import os

SCREENS_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "packages", "primecare_ui", "lib", "src", "screens"))

def main():
    print(f"Scanning directory: {SCREENS_DIR}...")
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
            
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()

            # We check if the file has a body Semantics injection
            if "body: Semantics(" in content:
                # Let's count parentheses to see if there is an unclosed Semantics widget
                # A simple and robust regex replacement of the trailing scaffold return brackets
                # The trailing Scaffold closing sequence looks exactly like:
                #       ),
                #     );
                #   }
                # }
                # Let's replace the last occurrence of "), \n    );" or "),\n    );" with "),\n    ),\n    );"
                # First let's count occurrences of "),\n    );" or similar
                # To be bulletproof, we target the closing brackets of buildScreen:
                # We find "),\n    );" and replace it with "),\n    ),\n    );"
                
                # Let's check if the file already has the fix applied
                # If there are already three closing brackets like "),\n    ),\n    );" we skip it.
                if "),\\n    )," in content or "),\\r\\n    )," in content or "),\\n      )," in content or "),\\r\\n      )," in content:
                    continue
                
                # Let's find the closing Scaffold return
                # We look for "),\r\n    );" or "),\n    );" right before buildScreen closing.
                # Since we know the buildScreen ends with:
                #       ),
                #     );
                #   }
                
                modified = False
                if "),\r\n    );" in content:
                    # Check that we don't double-replace if it's already fixed
                    # We can replace the last occurrence
                    idx = content.rfind("),\r\n    );")
                    if idx != -1:
                        # Let's check if there is an extra parenthesis before it
                        # If not, let's inject it
                        # To be safe, let's verify if the file compiles by checking if there's a Semantics widget
                        content = content[:idx] + "),\r\n    ),\r\n    );" + content[idx + len("),\r\n    );"):]
                        modified = True
                elif "),\n    );" in content:
                    idx = content.rfind("),\n    );")
                    if idx != -1:
                        content = content[:idx] + "),\n    ),\n    );" + content[idx + len("),\n    );"):]
                        modified = True
                
                if modified:
                    with open(file_path, "w", encoding="utf-8") as f:
                        f.write(content)
                    fixed_count += 1
                    # print(f"Fixed unclosed Semantics in: {file}")

    print(f"Scanned {scanned_count} files.")
    print(f"Successfully fixed unclosed Semantics brackets in {fixed_count} screen files!")

if __name__ == "__main__":
    main()
