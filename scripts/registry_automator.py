import os
import re
import json

# --- Configuration ---
PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
WAREHOUSE_PATH = f"{PROJECT_ROOT}/packages/factory_system/primecare_ui/lib/src/warehouse/01_I_component_warehouse.dart"
INTENTS_PATH = f"{PROJECT_ROOT}/.agents/ui_intents.json"
FEATURES_DIR = f"{PROJECT_ROOT}/packages/flutter_core/lib/features"
BARREL_PATH = f"{PROJECT_ROOT}/packages/flutter_core/lib/features/features_manifest.dart"
PACKAGE_NAME = "primecare_core"

def to_snake_case(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

def get_feature_group(name):
    if 'Dashboard' in name:
        prefix = name.split('Dashboard')[0]
        return f"{to_snake_case(prefix)}_dashboard"
    if 'Form' in name:
        if any(x in name for x in ['Clinical', 'CarePlan', 'Medication', 'Vitals', 'Infection', 'Incident', 'Adl', 'Census']):
            return "clinical_forms"
        if any(x in name for x in ['Expense', 'Payroll', 'Billing', 'Invoice', 'Reconciliation', 'Refunds', 'Revenue']):
            return "financial_forms"
        if any(x in name for x in ['Lead', 'Franchise', 'AdPlacement', 'MarketShare', 'Sale', 'BusDev', 'Marketing']):
            return "crm_forms"
        if any(x in name for x in ['Staff', 'Leave', 'Hr', 'Interview', 'Employee', 'Timesheet', 'Hiring', 'Discipline']):
            return "hr_forms"
        return "common_forms"
    if 'Icon' in name: return "shared/icons"
    if 'Layout' in name: return "shared/layouts"
    return "common_ui"

def generate_manifest():
    if not os.path.exists(INTENTS_PATH):
        print(f"Error: {INTENTS_PATH} not found.")
        return

    with open(INTENTS_PATH, 'r') as f:
        intents = json.load(f)

    exports = []
    for intent in intents:
        enum_name = intent['enumName']
        
        # FILTER: Skip non-UI components
        if any(x in enum_name for x in ['Adapter', 'Dto', 'Mapper', 'ViewModel', 'Command', 'Event', 'Signal', 'Provider']):
            continue
            
        feature_name = get_feature_group(enum_name)
        snake_name = to_snake_case(enum_name)
        
        # Standardized naming convention
        is_dashboard = "Dashboard" in enum_name
        
        # Strip Screen and Dashboard to get the base stem
        stem = snake_name.replace("_dashboard", "").replace("_screen", "")
        
        if is_dashboard:
            filename = f"05_U_{stem}_dashboard_screen.dart"
            path = f"package:{PACKAGE_NAME}/features/{feature_name}/presentation/widgets/{filename}"
        else:
            filename = f"{stem}_screen.dart"
            path = f"package:{PACKAGE_NAME}/features/{feature_name}/presentation/widgets/{filename}"
        
        exports.append(f"export '{path}';")

    with open(BARREL_PATH, 'w') as f:
        f.write("// AUTO-GENERATED FEATURES MANIFEST - DO NOT EDIT\n")
        f.write("// Total Screens: {}\n\n".format(len(exports)))
        f.write("\n".join(sorted(list(set(exports)))))
    
    print(f"Created manifest at {BARREL_PATH} with {len(exports)} exports.")

def update_warehouse():
    if not os.path.exists(WAREHOUSE_PATH):
        print(f"Error: {WAREHOUSE_PATH} not found.")
        return

    with open(INTENTS_PATH, 'r') as f:
        intents = json.load(f)

    with open(WAREHOUSE_PATH, 'r') as f:
        content = f.read()

    # 1. Update import to the correct manifest
    correct_import = f"import 'package:{PACKAGE_NAME}/features/features_manifest.dart';"
    if "features_manifest.dart" not in content:
        content = correct_import + "\n" + content
    else:
        # Ensure it's not the old 01_I_ version
        content = content.replace(f"import 'package:{PACKAGE_NAME}/features/01_I_features_manifest.dart';", correct_import)

    # 2. Sequential Replacement for Registry
    for intent in intents:
        enum_name = intent['enumName']
        
        # Only process if it's potentially a screen (not adapter etc)
        if any(x in enum_name for x in ['Adapter', 'Dto', 'Mapper', 'ViewModel']):
            continue
            
        class_name = enum_name[0].upper() + enum_name[1:]
        
        # Find and replace placeholders
        content = content.replace(f"'{enum_name}': (context, payload) => {class_name}Placeholder(data: payload),", 
                                  f"'{enum_name}': (context, payload) => {class_name}Screen(data: payload),")

    with open(WAREHOUSE_PATH, 'w') as f:
        f.write(content)
    
    print(f"Updated ComponentWarehouse at {WAREHOUSE_PATH}")

if __name__ == "__main__":
    generate_manifest()
    update_warehouse()
