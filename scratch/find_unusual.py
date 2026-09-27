import os

path = r"packages/primecare_ui/lib/primecare_ui.dart"
if os.path.exists(path):
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    for idx, line in enumerate(lines, 1):
        if 'PswDashboardScreen' in line or 'CareDashboardScreen' in line or 'psw_dashboard' in line:
            print(f"{idx}: {line.strip()}", flush=True)
else:
    print("File not found")
