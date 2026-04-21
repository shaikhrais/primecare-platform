import os
import re
import json

# --- Configuration ---
PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
WAREHOUSE_PATH = f"{PROJECT_ROOT}/packages/factory_system/primecare_ui/lib/src/warehouse/component_warehouse.dart"
INTENTS_PATH = f"{PROJECT_ROOT}/.agents/ui_intents.json"
FEATURES_DIR = f"{PROJECT_ROOT}/packages/flutter_core/lib/features"
BARREL_PATH = f"{PROJECT_ROOT}/packages/flutter_core/lib/features/features_manifest.dart"

def to_snake_case(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

def get_feature_group(name):
    if 'Dashboard' in name:
        prefix = name.split('Dashboard')[0]
        return f"{to_snake_case(prefix)}_dashboard"
    if 'Form' in name:
        if any(x in name for x in ['Clinical', 'CarePlan', 'Medication', 'Vitals', 'Infection', 'Incident', 'Adl', 'Census']):
            return "clinical_forms"
        if any(x in name for x in ['Expense', 'Payroll', 'Billing', 'Invoice', 'Reconciliation', 'Refunds', 'Revenue', 'Payroll', 'PettyCash']):
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
    with open(INTENTS_PATH, 'r') as f:
        intents = json.load(f)

    exports = []
    for intent in intents:
        enum_name = intent['enumName']
        feature_name = get_feature_group(enum_name)
        snake_name = to_snake_case(enum_name)
        path = f"package:primecare_core/features/{feature_name}/presentation/widgets/{snake_name}_screen.dart"
        exports.append(f"export '{path}';")

    with open(BARREL_PATH, 'w') as f:
        f.write("// AUTO-GENERATED FEATURES MANIFEST - DO NOT EDIT\n")
        f.write("\n".join(sorted(list(set(exports)))))
    
    print(f"Created manifest at {BARREL_PATH}")

def update_warehouse():
    with open(INTENTS_PATH, 'r') as f:
        intents = json.load(f)

    with open(WAREHOUSE_PATH, 'r') as f:
        content = f.read()

    # 1. Add import
    # import 'package:primecare_core/features/features_manifest.dart';
    if "features_manifest.dart" not in content:
        content = "import 'package:primecare_core/features/features_manifest.dart';\n" + content

    # 2. Sequential Replacement for Registry
    # Pattern: 'id': (context, payload) => ClassPlaceholder(data: payload),
    # Replace with: 'id': (context, payload) => ClassScreen(data: payload),
    for intent in intents:
        enum_name = intent['enumName']
        class_name = enum_name[0].upper() + enum_name[1:]
        placeholder_regex = rf"'{enum_name}': \(context, payload\) => {class_name}Placeholder\(data: payload\),"
        replacement = f"'{enum_name}': (context, payload) => {class_name}Screen(data: payload),"
        
        # Exact string match first
        content = content.replace(f"'{enum_name}': (context, payload) => {class_name}Placeholder(data: payload),", replacement)

    with open(WAREHOUSE_PATH, 'w') as f:
        f.write(content)
    
    print(f"Updated ComponentWarehouse at {WAREHOUSE_PATH}")

if __name__ == "__main__":
    generate_manifest()
    update_warehouse()
