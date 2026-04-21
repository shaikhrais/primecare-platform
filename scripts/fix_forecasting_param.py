import os
import re

ADAPTERS_DIR = 'packages/primecare_adapters/lib/src'
count = 0

for root, _, files in os.walk(ADAPTERS_DIR):
    for file in files:
        if file.endswith('_adapter.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            original_content = content
            
            # Remove `forecasting: forecasting,`
            content = re.sub(r'\s*forecasting:\s*forecasting,', '', content)
            
            # Remove `final forecasting = ...` (e.g. final forecasting = forecastingResult.fold((f) => f, (e) => null);)
            content = re.sub(r'(\s*)final\s+forecasting\s*=\s*\w+Result\.fold\([^\)]*\)\s*;\n?', r'\1', content)
            content = re.sub(r'(\s*)final\s+forecasting\s*=\s*\w+Result\.fold\([^\)]+\)[^;]*;\n?', r'\1', content)
            
            # regional_manager_ontario fix
            content = content.replace('PrimeCareDashboardViewModel.fromDashboardMetrics(', 'RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(')

            if content != original_content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"Updated {filepath}")
                count += 1

print(f"Total updated: {count}")
