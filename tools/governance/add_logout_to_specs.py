import os
import re

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SPECS_DIR = os.path.join(PROJECT_ROOT, "cypress", "e2e", "03_screens")

LOGOUT_BLOCK = """
    // Logout verification
    cy.task("log", "👆 PROGRESS: - Logging out...");
    cy.get("body").then(($body) => {
      const topbarLogout = $body.find('[aria-label*="data-cy:topbar-logout-button"], [aria-label*="topbar-logout-button"], [key="topbar-logout-button"], [data-cy="topbar-logout-button"]');
      if (topbarLogout.length > 0) {
        cy.wrap(topbarLogout).first().click({ force: true });
      } else {
        // Fallback: clear storage and redirect to /login
        cy.clearAllCookies();
        cy.clearAllLocalStorage();
        cy.clearAllSessionStorage();
        cy.location("origin").then((origin) => {
          const baseUrl = origin && origin !== "null" ? origin : "";
          cy.visit(`${baseUrl}/login?enable-semantics=true`);
        });
      }
    });
    cy.waitAndSee();
    cy.url().should("include", "/login");
"""

def main():
    print("==============================================================")
    print("PRIMECARE GOVERNANCE: ADDING LOGOUT VERIFICATION TO SPECS")
    print("==============================================================")

    if not os.path.exists(SPECS_DIR):
        print(f"Error: Directory not found at {SPECS_DIR}")
        return

    files = [f for f in os.listdir(SPECS_DIR) if f.endswith(".cy.js")]
    print(f"Found {len(files)} Cypress screen spec files.")

    updated_count = 0

    for filename in files:
        file_path = os.path.join(SPECS_DIR, filename)

        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
        except Exception as e:
            print(f"  Error reading {filename}: {e}")
            continue

        # Skip if logout logic already exists in the file
        if "Logging out..." in content or "topbar-logout-button" in content:
            continue

        # Find the last }); of the it(...) block before the describe closing block
        # Typically ends with:
        #   cy.task("log", "✅ PROGRESS: - Verified ... successfully!\n");
        #
        #   });
        # });
        
        pattern = r"(\s*cy\.task\(\"log\",\s*\"✅ PROGRESS: - Verified [a-zA-Z0-9_]+ successfully!\\n\"\);\s*)(?=\n\s*\}\);\s*\}\);\s*$)"
        match = re.search(pattern, content)
        
        if match:
            # Insert logout block right after the "Verified successfully" log statement
            target_str = match.group(0)
            replacement_str = target_str + LOGOUT_BLOCK
            new_content = content.replace(target_str, replacement_str)

            try:
                with open(file_path, "w", encoding="utf-8") as f:
                    f.write(new_content)
                updated_count += 1
            except Exception as e:
                print(f"  Error writing {filename}: {e}")
        else:
            # Try a broader matching pattern: find the last }); of it block
            # and insert it before the last });
            parts = content.rsplit("});", 2)
            if len(parts) >= 3:
                # parts[-3] is everything before the it block closing
                # parts[-2] is the whitespace between it closing and describe closing
                # parts[-1] is the whitespace after describe closing
                new_content = parts[0] + LOGOUT_BLOCK + "  });" + parts[1] + "});" + parts[2]
                try:
                    with open(file_path, "w", encoding="utf-8") as f:
                        f.write(new_content)
                    updated_count += 1
                except Exception as e:
                    print(f"  Error writing {filename}: {e}")

    print("==============================================================")
    print(f"Successfully added logout step to {updated_count} spec files.")
    print("==============================================================")

if __name__ == "__main__":
    main()
