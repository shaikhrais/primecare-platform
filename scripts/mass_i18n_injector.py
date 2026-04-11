import os
import re
import json

base_ui_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_ui\lib\src\screens\offices"
json_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\assets\translations"

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

def process_dashboards():
    dashboards = []
    
    # 1. Glob all dashboard.dart files
    for root, dirs, files in os.walk(base_ui_dir):
        for file in files:
            if file.endswith('_dashboard.dart') or file == 'dashboard.dart':
                dashboards.append(os.path.join(root, file))

    print(f"Found {len(dashboards)} potential dashboard files.")
    
    # JSON Data
    with open(os.path.join(json_dir, 'en.json'), 'r', encoding='utf-8') as f:
        en_data = json.load(f)
    with open(os.path.join(json_dir, 'fr.json'), 'r', encoding='utf-8') as f:
        fr_data = json.load(f)
    with open(os.path.join(json_dir, 'es.json'), 'r', encoding='utf-8') as f:
        es_data = json.load(f)

    test_blocks = []
    imports_for_tests = []

    for path in dashboards:
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()

        if '.tr()' in content:
            continue # already processed
            
        office = os.path.basename(os.path.dirname(os.path.dirname(path)))
        if office == 'offices': 
            office = os.path.basename(os.path.dirname(path))

        # Infer role from filename
        filename = os.path.basename(path)
        role = filename.replace('_dashboard.dart', '')
        if role == 'dashboard':
            role = office # fallback if just dashboard.dart
            
        role_camel = to_camel_case(role)

        # Regex replacements
        title_match = re.search(r"Text\(\s*'([^']+Dashboard)',", content)
        if not title_match:
            continue
            
        original_title = title_match.group(1)
        
        # Replace Title
        content = re.sub(
            r"Text\(\s*'[^']+Dashboard',\s*style:\s*Theme\.of\(context\)\.textTheme\.headlineMedium",
            f"Text(\n              '{office}.{role_camel}.dashboard.title'.tr(),\n              style: Theme.of(context).textTheme.headlineMedium",
            content
        )
        
        # Replace Subtitle
        content = re.sub(
            r"Text\(\s*'Real-time overview fetched natively via API.',",
            f"Text(\n              '{office}.{role_camel}.dashboard.subtitle'.tr(),",
            content
        )

        # Add import if missing
        if "easy_localization.dart" not in content:
            content = content.replace(
                "import 'package:flutter_core/flutter_core.dart';",
                "import 'package:flutter_core/flutter_core.dart';\nimport 'package:easy_localization/easy_localization.dart';"
            )

        with open(path, 'w', encoding='utf-8') as f:
            f.write(content)

        # Update JSON objects
        if office not in en_data:
            en_data[office] = {}
        if office not in fr_data:
            fr_data[office] = {}
        if office not in es_data:
            es_data[office] = {}
            
        if role_camel not in en_data[office]:
            en_data[office][role_camel] = {}
        if role_camel not in fr_data[office]:
            fr_data[office][role_camel] = {}
        if role_camel not in es_data[office]:
            es_data[office][role_camel] = {}
            
        # Add actual translation keys
        en_data[office][role_camel]['dashboard'] = {
            "title": original_title,
            "subtitle": "Real-time overview fetched natively via API."
        }
        fr_data[office][role_camel]['dashboard'] = {
            "title": original_title.replace("Dashboard", "Tableau de Bord"),
            "subtitle": "Aperçu en temps réel récupéré nativement via l'API."
        }
        es_data[office][role_camel]['dashboard'] = {
            "title": original_title.replace("Dashboard", "Panel"),
            "subtitle": "Visión general en tiempo real obtenida nativamente vía API."
        }

        # Setup test generation
        # Find the widget class name
        class_match = re.search(r'class (\w+) extends ConsumerWidget', content)
        if class_match:
            class_name = class_match.group(1)
            rel_import = path.split('packages\\flutter_ui\\lib\\')[1].replace('\\', '/')
            imports_for_tests.append(f"import 'package:flutter_ui/{rel_import}';")
            
            test_blocks.append(f"""
    testWidgets('Verify {class_name} hydration', (tester) async {{
      await tester.pumpWidget(MasterDashboardPageObject.wrapWithAdapters(const {class_name}()));
      final dashboard = MasterDashboardPageObject(tester);
      await dashboard.waitForHydration();
      
      await dashboard.verifyTitle('{office}.{role_camel}.dashboard.title');
      await dashboard.verifySubtitle('{office}.{role_camel}.dashboard.subtitle');
    }});""")

    # Save JSON files
    with open(os.path.join(json_dir, 'en.json'), 'w', encoding='utf-8') as f:
        json.dump(en_data, f, indent=2, ensure_ascii=False)
    with open(os.path.join(json_dir, 'fr.json'), 'w', encoding='utf-8') as f:
        json.dump(fr_data, f, indent=2, ensure_ascii=False)
    with open(os.path.join(json_dir, 'es.json'), 'w', encoding='utf-8') as f:
        json.dump(es_data, f, indent=2, ensure_ascii=False)

    print("Modified Dart files and updated JSON translation maps.")

    # Create the test file
    test_file_path = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_corporate\test\extended_dashboards_adapter_test.dart"
    
    unique_imports = "\n".join(sorted(list(set(imports_for_tests))))
    tests_str = "\n".join(test_blocks)
    
    test_content = f"""import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
{unique_imports}
import '../integration_test/page_objects/master_dashboard_page.dart';

void main() {{
  setUpAll(() {{
    DataSourceConfig.currentMode = DataSourceType.mock;
  }});

  group('Extended E2E Dashboard Adapter Hydration Validation', () {{
{tests_str}
  }});
}}
"""
    with open(test_file_path, 'w', encoding='utf-8') as f:
        f.write(test_content)
        
    print(f"Generated {len(test_blocks)} widget tests in extended_dashboards_adapter_test.dart")

if __name__ == "__main__":
    process_dashboards()
