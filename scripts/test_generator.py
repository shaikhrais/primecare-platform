import os
import re

base_ui_dir = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_ui\lib\src\screens\offices"

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

def generate_tests():
    dashboards = []
    
    for root, dirs, files in os.walk(base_ui_dir):
        for file in files:
            if file.endswith('_dashboard.dart') or file == 'dashboard.dart':
                dashboards.append(os.path.join(root, file))

    test_blocks = []
    imports_for_tests = []

    for path in dashboards:
        with open(path, 'r', encoding='utf-8') as f:
            content = f.read()

        office = os.path.basename(os.path.dirname(os.path.dirname(path)))
        if office == 'offices': 
            office = os.path.basename(os.path.dirname(path))

        filename = os.path.basename(path)
        role = filename.replace('_dashboard.dart', '')
        if role == 'dashboard':
            role = office
            
        role_camel = to_camel_case(role)

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
    generate_tests()
