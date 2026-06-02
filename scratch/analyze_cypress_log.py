import os
import re

log_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\16a38336-fd7b-4e22-b47c-76766e261713\.system_generated\tasks\task-12002.log"

if not os.path.exists(log_path):
    print(f"Log file not found at: {log_path}")
    exit(1)

with open(log_path, 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

# Split log into specs
specs = content.split("Running:  ")
print(f"Total Spec blocks parsed: {len(specs)}")

total_run = 0
passed_specs = []
failed_specs = []

for spec in specs[1:]:
    lines = spec.strip().split("\n")
    if not lines:
        continue
    
    spec_title_match = re.search(r"screen_[a-zA-Z0-9_]+\.cy\.js", lines[0])
    if not spec_title_match:
        continue
    
    spec_name = spec_title_match.group(0)
    total_run += 1
    
    # Check for failure
    is_failed = False
    fail_reason = ""
    
    # We can check for "failing" or "1 failing" or "(Results)" table
    # Let's search inside the spec block for a table with failing > 0
    # or "failing" strings.
    results_match = re.search(r"│\s+Failing:\s+(\d+)\s+│", spec)
    if results_match:
        failing_count = int(results_match.group(1))
        if failing_count > 0:
            is_failed = True
    else:
        # Fallback check
        if "failing" in spec.lower() or "AssertionError" in spec or "CypressError" in spec:
            is_failed = True
            
    # Try to extract the error message
    if is_failed:
        error_match = re.search(r"\d+\)\s+Screen[^\n]+\n([^\n]+(?:\n[^\n]+){0,5})", spec)
        if error_match:
            fail_reason = error_match.group(1).strip()
        else:
            # Fallback to look for AssertionError/CypressError
            err_line_match = re.search(r"(?:AssertionError|CypressError):[^\n]+", spec)
            if err_line_match:
                fail_reason = err_line_match.group(0)
            else:
                fail_reason = "Unknown failure reason (see log)"
        
        failed_specs.append((spec_name, fail_reason))
    else:
        passed_specs.append(spec_name)

# Categorize failure reasons
failure_categories = {
    "Spec Bridge Failure": 0,
    "Origin Mismatch / Expected to run against...": 0,
    "SSO Consent Timeout / primecare-auth": 0,
    "Other/Unknown": 0
}

for name, reason in failed_specs:
    if "spec bridge" in reason.lower() or "spec bridge" in name.lower():
        failure_categories["Spec Bridge Failure"] += 1
    elif "expected to run against origin" in reason.lower():
        failure_categories["Origin Mismatch / Expected to run against..."] += 1
    elif "primecare-auth.pages.dev" in reason.lower() or "consent" in reason.lower():
        failure_categories["SSO Consent Timeout / primecare-auth"] += 1
    else:
        failure_categories["Other/Unknown"] += 1

print("\n--- CYPRESS SWEEP SUMMARY ---")
print(f"Total Specs Processed so far: {total_run}")
print(f"Passing Specs: {len(passed_specs)}")
print(f"Failing Specs: {len(failed_specs)}")

print("\n--- FAILURE CATEGORY BREAKDOWN ---")
for cat, count in failure_categories.items():
    print(f"- {cat}: {count} ({count/len(failed_specs)*100:.1f}%)" if len(failed_specs) > 0 else f"- {cat}: {count}")

# Print only the first 10 failures to keep output clean and avoid truncation
print("\n--- FIRST 10 FAILED SPECS DETAIL ---")
for idx, (name, reason) in enumerate(failed_specs[:10], 1):
    cleaned_reason = "\n    ".join(reason.split("\n"))
    safe_reason = cleaned_reason.encode('ascii', errors='backslashreplace').decode('ascii')
    safe_name = name.encode('ascii', errors='backslashreplace').decode('ascii')
    print(f"{idx}. {safe_name}:\n    {safe_reason}\n")



