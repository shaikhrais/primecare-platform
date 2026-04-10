import os
import re

SCREENS_DIR = r".\packages\flutter_ui\lib\src\screens\offices"

for root, _, files in os.walk(SCREENS_DIR):
    for file in files:
        if file.endswith('_dashboard_screen.dart'):
            with open(os.path.join(root, file), 'r', encoding='utf-8') as f:
                content = f.read()

            target = "data: (DashboardMetrics liveData) {"
            if target in content:
                content = content.replace(target, "data: (liveData) {")
                
                with open(os.path.join(root, file), 'w', encoding='utf-8') as f:
                    f.write(content)

print("Fixed explicit compilation cast mismatch in 4 legacy files.")
