import os
import re
import sqlite3
from pathlib import Path

# Paths
DB_PATH = Path(r"C:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db")
PLATFORM_DIR = Path(r"C:\Users\Admin2\Documents\GitHub\primecare-platform")
REPORT_PATH = PLATFORM_DIR / "COMPONENT_SELECTOR_AUDIT.md"

def is_kebab_case(s):
    # Enforces lowercase, kebab-case, no spaces, no random numbers
    if not s:
        return False
    if not re.match(r'^[a-z0-9\-]+$', s):
        return False
    # Check for random-like dynamic patterns (e.g. button123, test1, but numeric suffixes are sometimes okay if static, so check length/entropy)
    if re.search(r'[a-z]+[0-9]{4,}', s): # 4+ digits is likely random
        return False
    return True

def main():
    print("--- STARTING CYPRESS SELECTOR VALIDATION AUDIT ---")
    
    # 1. Read selectors from SQLite Database
    db_selectors = set()
    db_by_id = {}
    if DB_PATH.exists():
        try:
            conn = sqlite3.connect(DB_PATH)
            cur = conn.cursor()
            cur.execute("SELECT component_id, component_name, data_cy, screen_id, required FROM component_test_registry WHERE active = 1;")
            rows = cur.fetchall()
            for r in rows:
                comp_id, name, data_cy, scr_id, req = r
                if data_cy:
                    db_selectors.add(data_cy)
                    db_by_id[data_cy] = {
                        "id": comp_id,
                        "name": name,
                        "screen_id": scr_id,
                        "required": req
                    }
            conn.close()
            print(f"Loaded {len(db_selectors)} active selectors from governance.db component_test_registry.")
        except Exception as e:
            print(f"Error reading DB: {e}")
    else:
        print(f"Warning: database not found at {DB_PATH}")

    # 2. Scan Dart Codebase for selectors
    code_selectors = {}
    total_components_scanned = 0
    invalid_selectors = []
    
    # Regex to find: Cy(id: "value") or dataCy: "value" or label: "data-cy:value" or label: "dy-data:value"
    # Matches both single and double quotes
    patterns = [
        re.compile(r'Cy\s*\(\s*id\s*:\s*[\'"]([^\'"]+)[\'"]'),
        re.compile(r'dataCy\s*:\s*[\'"]([^\'"]+)[\'"]'),
        re.compile(r'label\s*:\s*[\'"](?:data-cy|dy-data):([^\'"]+)[\'"]')
    ]
    
    scan_dirs = [
        PLATFORM_DIR / "packages" / "primecare_ui" / "lib",
        PLATFORM_DIR / "apps"
    ]
    
    for s_dir in scan_dirs:
        if not s_dir.exists():
            continue
        for root, dirs, files in os.walk(s_dir):
            if any(p in root for p in [".git", ".dart_tool", "build", "node_modules"]):
                continue
            for file in files:
                if file.endswith(".dart"):
                    path = os.path.join(root, file)
                    rel_path = os.path.relpath(path, PLATFORM_DIR)
                    try:
                        with open(path, "r", encoding="utf-8") as f:
                            content = f.read()
                        
                        for pattern in patterns:
                            matches = pattern.findall(content)
                            for match in matches:
                                # Sometimes multiple values are in a single Semantics label (e.g. 'dy-data:x data-cy:x')
                                # Split by space and clean
                                for part in match.split():
                                    clean_match = part.replace("data-cy:", "").replace("dy-data:", "").strip()
                                    if not clean_match:
                                        continue
                                    total_components_scanned += 1
                                    
                                    if clean_match not in code_selectors:
                                        code_selectors[clean_match] = []
                                    code_selectors[clean_match].append(rel_path)
                                    
                                    if not is_kebab_case(clean_match):
                                        invalid_selectors.append((clean_match, rel_path))
                    except Exception as e:
                        pass

    # 3. Calculate metrics
    total_distinct_code_selectors = len(code_selectors)
    
    # Duplicate selectors in code (used in more than one place)
    duplicate_selectors = {}
    for selector, files in code_selectors.items():
        if len(files) > 1:
            duplicate_selectors[selector] = files

    # Unused selectors (in DB but not in code)
    unused_selectors = []
    for selector in db_selectors:
        if selector not in code_selectors:
            unused_selectors.append(selector)

    # Missing from DB (in code but not in DB)
    missing_from_db = []
    for selector in code_selectors:
        if selector not in db_selectors:
            missing_from_db.append(selector)

    # Missing data-cy (components in DB that have missing or empty data_cy)
    missing_data_cy_in_db = []
    if DB_PATH.exists():
        try:
            conn = sqlite3.connect(DB_PATH)
            cur = conn.cursor()
            cur.execute("SELECT component_id, component_name, screen_id FROM component_test_registry WHERE data_cy IS NULL OR data_cy = '' AND active = 1;")
            for r in cur.fetchall():
                missing_data_cy_in_db.append(f"ID {r[0]}: {r[1]} (Screen {r[2]})")
            conn.close()
        except Exception:
            pass

    # 4. Generate report
    report_content = f"""# Component Selector Audit Report

This report summarizes the compliance and coverage of Cypress/E2E test selectors (`data-cy`) across the PrimeCare platform.

## Summary Metrics

* **Total Scanned Selectors in Code**: {total_components_scanned}
* **Total Distinct Selectors in Code**: {total_distinct_code_selectors}
* **Active Selectors Registered in DB**: {len(db_selectors)}
* **Duplicate Selectors in Code**: {len(duplicate_selectors)}
* **Invalid Naming Selectors**: {len(invalid_selectors)}
* **Unused Selectors (Registered but not in Code)**: {len(unused_selectors)}
* **Missing from DB (In Code but not Registered)**: {len(missing_from_db)}
* **Registered Components Missing data-cy**: {len(missing_data_cy_in_db)}

---

## Duplicate Selectors in Code

{"No duplicates detected." if not duplicate_selectors else ""}
"""
    if duplicate_selectors:
        report_content += "| Selector | File Occurrences |\n|---|---|\n"
        for sel, files in duplicate_selectors.items():
            files_str = "<br>".join(files)
            report_content += f"| `{sel}` | {files_str} |\n"

    report_content += """
---

## Invalid Naming Selectors (Must be lowercase, kebab-case, no spaces)

{"No invalid selectors detected." if not invalid_selectors else ""}
"""
    if invalid_selectors:
        report_content += "| Selector | File Location |\n|---|---|\n"
        for sel, file in invalid_selectors:
            report_content += f"| `{sel}` | `{file}` |\n"

    report_content += """
---

## Unused Selectors (Registered in DB but not found in Code)

{"No unused selectors." if not unused_selectors else ""}
"""
    if unused_selectors:
        report_content += "| Selector | DB Reference Name |\n|---|---|\n"
        for sel in sorted(unused_selectors)[:100]: # Cap to 100 for readability
            name = db_by_id[sel]["name"] if sel in db_by_id else "Unknown"
            report_content += f"| `{sel}` | {name} |\n"
        if len(unused_selectors) > 100:
            report_content += f"\n*...and {len(unused_selectors) - 100} more.*\n"

    report_content += """
---

## Missing from DB (Defined in Code but not Registered in DB)

{"No missing selectors." if not missing_from_db else ""}
"""
    if missing_from_db:
        report_content += "| Selector | File Location |\n|---|---|\n"
        for sel in sorted(missing_from_db)[:100]:
            files_str = "<br>".join(code_selectors[sel])
            report_content += f"| `{sel}` | {files_str} |\n"
        if len(missing_from_db) > 100:
            report_content += f"\n*...and {len(missing_from_db) - 100} more.*\n"

    REPORT_PATH.write_text(report_content, encoding="utf-8")
    print(f"\n[OK] Selector validation audit complete. Report written to: {REPORT_PATH.resolve()}")

if __name__ == "__main__":
    main()
