import sys
import os
import re

# Ensure unicode safe terminal output on Windows console
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')

print("=====================================================")
print("CI/CD Compliance: Verifying Physical File Header Comments")
print("=====================================================")

gov_dir = os.path.dirname(os.path.abspath(__file__))
screens_dir = os.path.join(os.path.dirname(os.path.dirname(gov_dir)), "packages", "primecare_ui", "lib", "src", "screens")

if not os.path.exists(screens_dir):
    print(f"[FATAL] UI screens directory not found at: {screens_dir}")
    sys.exit(1)

def find_dashboard_files(directory):
    files = []
    for root, _, filenames in os.walk(directory):
        for name in filenames:
            name_lower = name.lower()
            if name_lower.endswith('_dashboard_screen.dart') or name_lower.endswith('_dashboard.dart'):
                files.append(os.path.join(root, name))
    return files

# 1. Discover physical dashboard screen files on disk
physical_files = find_dashboard_files(screens_dir)
print(f"Checking physical header comments on {len(physical_files)} screen files...")

# 2. Iterate and verify the first line header comment is present and valid
violations = []
for path in physical_files:
    rel_path = os.path.relpath(path, os.path.dirname(os.path.dirname(gov_dir))).replace('\\', '/')
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            first_line = f.readline().strip()
    except Exception as e:
        violations.append(f"READ ERROR: {rel_path} - Failed to read: {e}")
        continue

    # Verify if the line starts with standard comment category signature
    if not first_line.startswith("// Governance - Category:"):
        violations.append(f"HEADER VIOLATION: {rel_path} - Missing or malformed governance header on line 1. (Found: '{first_line[:80]}...')")

if violations:
    print("\n[🔴 FAILED] PHYSICAL SOFTWARE GOVERNANCE HEADER VIOLATION(S) DETECTED!")
    for v in violations:
        print(f"  - {v}")
    print("\n[TIP] Physical files must have a first-line governance comment tag, e.g.:")
    print("  // Governance - Category: view | Purpose: technical purpose...")
    sys.exit(1)

print("\n[🟢 SUCCESS] All physical dashboard screen files have correct first-line governance headers intact.")
sys.exit(0)
