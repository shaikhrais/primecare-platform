import os
import re

def snake_case(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

directory = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\scaffolded'

for filename in os.listdir(directory):
    if filename.endswith(".dart") and filename.startswith("05_U_") and filename != "05_U_scaffolded.dart":
        path = os.path.join(directory, filename)
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract class name
        match = re.search(r'class (\w+) extends', content)
        if not match:
            continue
        
        class_name = match.group(1)
        key_name = snake_case(class_name)
        
        # Add import if missing
        if "import 'package:easy_localization/easy_localization.dart';" not in content:
            content = content.replace(
                "import 'package:primecare_ui/primecare_ui.dart';",
                "import 'package:primecare_ui/primecare_ui.dart';\nimport 'package:easy_localization/easy_localization.dart';"
            )
        
        # Replace title and subtitle
        # title: 'ApiMonitoring', -> title: 'navigation.items.api_monitoring'.tr(),
        # subtitle: 'Auto-scaffolded module', -> subtitle: 'navigation.items.api_monitoring'.tr(), (or leave it if not in dict)
        
        # We'll replace title with the key. For subtitle, we'll just use a generic one or leave it for now.
        # Actually, the user wants a full fix.
        
        content = re.sub(
            r"title: '.*?'",
            f"title: 'navigation.items.{key_name}'.tr()",
            content
        )
        
        # Remove const from PageTemplate
        content = content.replace("return const PageTemplate(", "return PageTemplate(")
        
        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed {filename}")
