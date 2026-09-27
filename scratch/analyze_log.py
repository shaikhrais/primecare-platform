import os
import sys

# Force UTF-8 stdout for Windows consoles
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

log_path = r"C:\Users\Admin2\.gemini\antigravity-ide\brain\d4c36703-d179-45fa-8c73-5c23e282a4c4\.system_generated\tasks\task-1203.log"

def analyze():
    if not os.path.exists(log_path):
        print("Log file not found.")
        return
        
    print("Reading log...")
    failures = []
    current_test = ""
    with open(log_path, "r", encoding="utf-8", errors="ignore") as f:
        for line in f:
            if "CFO Screens Visual Previews cfo_" in line:
                current_test = line.strip()
            if "EXCEPTION CAUGHT" in line or "TestFailure" in line or "AssertionError" in line or "Failed assertion" in line:
                failures.append((current_test, line.strip()))
                
    print(f"Found {len(failures)} error indicators:")
    for test, failure in failures[:30]:
        print(f"Test: {test} -> {failure}")

if __name__ == "__main__":
    analyze()
