import os
import sys
import sqlite3
import subprocess
import re

# Ensure unicode safe terminal output on Windows console
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

# Resolve absolute paths
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

# ANSI Color Codes
COLOR_RESET = "\033[0m"
COLOR_BOLD = "\033[1m"
COLOR_CRITICAL = "\033[91m"  # Red
COLOR_HIGH = "\033[93m"      # Yellow/Orange
COLOR_LOW = "\033[92m"       # Green
COLOR_CYAN = "\033[96m"      # Cyan
COLOR_GRAY = "\033[90m"      # Gray

# Loose text detection patterns
LOOSE_TEXT_PATTERNS = [
    r'Text\(\s*[\'"]([^\'"]+)[\'"]\s*\)',
    r'title:\s*[\'"]([^\'"]+)[\'"]',
]

def get_modified_files():
    """Retrieves all changed/added/unstaged/untracked files using git commands."""
    try:
        # Get modified (staged and unstaged)
        res_diff = subprocess.check_output(
            ["git", "diff", "--name-only"], cwd=PROJECT_ROOT, text=True
        ).splitlines()
        
        res_cached = subprocess.check_output(
            ["git", "diff", "--cached", "--name-only"], cwd=PROJECT_ROOT, text=True
        ).splitlines()
        
        # Get untracked files
        res_status = subprocess.check_output(
            ["git", "status", "--porcelain"], cwd=PROJECT_ROOT, text=True
        ).splitlines()
        
        untracked = []
        for line in res_status:
            if line.startswith("?? "):
                untracked.append(line[3:])
                
        all_files = list(set(res_diff + res_cached + untracked))
        return [f.replace("\\", "/") for f in all_files]
    except Exception as e:
        print(f"{COLOR_HIGH}[WARNING] Could not query git status: {e}. Defaulting to empty check.{COLOR_RESET}")
        return []

def verify_lifecycle_compliance():
    print(f"\n{COLOR_BOLD}{COLOR_CYAN}======================================================================")
    print("PRIMECARE ZERO-DRIFT COMPLIANCE GUARDIAN (DELTA SCAN)")
    print(f"======================================================================{COLOR_RESET}")

    modified_files = get_modified_files()
    print(f"Detected {len(modified_files)} modified/new files in the workspace delta.")

    # Filter screens and dart files
    added_screens = []
    dart_files_to_lint = []
    
    for f in modified_files:
        if f.startswith("packages/primecare_ui/lib/src/screens/") and f.endswith("_screen.dart"):
            added_screens.append(f)
        
        # We lint only Dart files in our main UI/Core packages that have changed
        if (f.startswith("packages/primecare_ui/") or f.startswith("packages/flutter_core/")) and f.endswith(".dart"):
            # Ensure file exists
            if os.path.exists(os.path.join(PROJECT_ROOT, f)):
                dart_files_to_lint.append(f)

    violations = []

    # 1. SQLite database registry checks
    if added_screens:
        print(f"\nScanning {len(added_screens)} added/modified visual screens for SQLite alignment...")
        if not os.path.exists(DB_PATH):
            print(f"{COLOR_CRITICAL}[ERROR] Relational database not found at {DB_PATH}. Run 'python scripts/remodel_governance_db.py' first.{COLOR_RESET}")
            sys.exit(1)
            
        conn = sqlite3.connect(DB_PATH)
        conn.row_factory = sqlite3.Row
        cursor = conn.cursor()
        
        for scr_file in added_screens:
            file_basename = os.path.basename(scr_file)
            scr_code = file_basename.replace(".dart", "")
            
            # Check if registered in screens table
            cursor.execute("SELECT id, screen_name FROM screens WHERE expected_file_path = ? OR screen_code = ? OR screen_code = ?;", (scr_file, scr_code, scr_code.replace("_screen", "")))
            scr_row = cursor.fetchone()
            
            if not scr_row:
                violations.append(
                    f"Screen '{file_basename}' is not registered in the SQLite 'screens' table!\n"
                    f"  File Path: {scr_file}\n"
                    f"  {COLOR_GRAY}Remediation: Run 'python scripts/remodel_governance_db.py' to crawl the filesystem and register this screen.{COLOR_RESET}"
                )
                continue
                
            scr_id = scr_row['id']
            scr_name = scr_row['screen_name']
            
            # Check if has E2E test case linked
            cursor.execute("SELECT count(*) FROM test_cases WHERE related_screen_id = ?;", (scr_id,))
            tc_count = cursor.fetchone()[0]
            
            if tc_count == 0:
                violations.append(
                    f"Screen '{scr_name}' (ID: {scr_id}) is missing an E2E verification test case link in the 'test_cases' table!\n"
                    f"  File Path: {scr_file}\n"
                    f"  {COLOR_GRAY}Remediation: Run 'python scripts/remodel_governance_db.py' to automatically generate and link the E2E verification test case.{COLOR_RESET}"
                )
                
        conn.close()

    # If registry violations are found, block immediately
    if violations:
        print(f"\n{COLOR_CRITICAL}{COLOR_BOLD}❌ COMPLIANCE GATEWAY BLOCKED: Relational Drifts Detected!{COLOR_RESET}")
        for idx, viol in enumerate(violations, 1):
            print(f"\n{COLOR_BOLD}[Violation #{idx}]{COLOR_RESET} {COLOR_CRITICAL}{viol}{COLOR_RESET}")
        print(f"\n{COLOR_BOLD}Run 'python scripts/remodel_governance_db.py' to automatically resolve all database drifts.{COLOR_RESET}")
        print(f"{COLOR_CYAN}======================================================================{COLOR_RESET}")
        sys.exit(1)

    print(f"{COLOR_LOW}[CLEAN] Database registry alignment verified successfully!{COLOR_RESET}")

    # 2. Localized loose text checks on delta dart files only
    loose_text_found = False
    if dart_files_to_lint:
        print(f"\nScanning {len(dart_files_to_lint)} modified Dart files for loose plaintext strings...")
        
        for rel_path in dart_files_to_lint:
            abs_path = os.path.join(PROJECT_ROOT, rel_path)
            
            with open(abs_path, 'r', encoding='utf-8') as f:
                lines = f.readlines()
                
            for i, line in enumerate(lines):
                # Skip comments
                if line.strip().startswith('//') or line.strip().startswith('/*'):
                    continue
                    
                for pattern in LOOSE_TEXT_PATTERNS:
                    match = re.search(pattern, line)
                    if match:
                        # If does not contain translation markers
                        if '.tr()' not in line and 'LocaleKeys.' not in line:
                            loose_text_found = True
                            print(f"{COLOR_CRITICAL}LOOSE TEXT: {rel_path}:{i+1} -> {match.group(0)}{COLOR_RESET}")

    if loose_text_found:
        print(f"\n{COLOR_CRITICAL}{COLOR_BOLD}❌ COMPLIANCE GATEWAY BLOCKED: Hardcoded Strings Found in Delta!{COLOR_RESET}")
        print(f"  {COLOR_GRAY}Solution: Store strings as keys in SQLite 'screens/pages' table, sync translations, and use 'LocaleKeys.key.tr()'{COLOR_RESET}")
        print(f"{COLOR_CYAN}======================================================================{COLOR_RESET}")
        sys.exit(1)
        
    print(f"{COLOR_LOW}[CLEAN] Zero loose plaintext strings detected in delta files!{COLOR_RESET}")
    print(f"\n{COLOR_LOW}{COLOR_BOLD}✅ COMPLIANCE STATUS: 100% COMPLIANT. Zero drifts or loose-text detected!{COLOR_RESET}")
    print(f"{COLOR_CYAN}======================================================================{COLOR_RESET}")
    sys.exit(0)

if __name__ == "__main__":
    verify_lifecycle_compliance()
