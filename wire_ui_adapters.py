import os
import re

SCREENS_DIR = r".\packages\flutter_ui\lib\src\screens\offices"

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

count = 0

for root, _, files in os.walk(SCREENS_DIR):
    for file in files:
        if file.endswith('_dashboard_screen.dart'):
            feature_name = file.replace('_screen.dart', '')
            camel_name = to_camel_case(feature_name)
            
            fp = os.path.join(root, file)
            with open(fp, "r", encoding="utf-8") as f:
                content = f.read()

            original = content
            
            # 1. Replace the provider call:
            content = re.sub(r"final\s+metricsAsyncValue\s*=\s*ref\.watch\(dashboardMetricsProvider\([^)]+\)\);",
                             f"final viewModelAsyncValue = ref.watch({camel_name}AdapterProvider);", content)

            # 2. Replace metricsAsyncValue.when with viewModelAsyncValue.when
            content = content.replace("metricsAsyncValue.when(", "viewModelAsyncValue.when(")

            # 3. Replace data: (metrics) => PageTemplate( with data: (viewModel) => PageTemplate(
            content = content.replace("data: (metrics) => PageTemplate(", "data: (viewModel) => PageTemplate(")
            
            # 4. Replace metrics.kpis -> viewModel.kpis
            content = content.replace("metrics.kpis", "viewModel.kpis")
            
            # 5. Replace metrics.recentActivity -> viewModel.recentActivity
            content = content.replace("metrics.recentActivity", "viewModel.recentActivity")
            
            if content != original:
                with open(fp, "w", encoding="utf-8") as f:
                    f.write(content)
                count += 1

print(f"Wired UI adapters into {count} screens.")
