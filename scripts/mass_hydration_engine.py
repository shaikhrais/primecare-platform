import json
import os
import re

# --- Configuration ---
PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
FEATURES_DIR = f"{PROJECT_ROOT}/packages/flutter_core/lib/features"
INTENTS_PATH = f"{PROJECT_ROOT}/.agents/ui_intents.json"

# --- Templates ---

VIEW_MODEL_TEMPLATE = """
import 'package:primecare_core/flutter_core.dart';

class {className}ViewModel extends PrimeCareViewModel {{
  final String title;
  final Map<String, dynamic> metadata;

  {className}ViewModel({{
    required this.title,
    this.metadata = const {{}},
  }});

  @override
  List<Object?> get props => [title, metadata];
}}
"""

SCREEN_TEMPLATE = """
import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class {className}Screen extends ConsumerWidget {{
  final dynamic data;
  
  const {className}Screen({{super.key, this.data}});

  @override
  Widget build(BuildContext context, WidgetRef ref) {{
    return PrimeCareScaffold(
      title: '{title}',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.component, size: 64, color: PrimeCareColors.primary),
            const SizedBox(height: 16),
            Text(
              '{title} Implementation',
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('This component is part of the {featureName} module.'),
          ],
        ),
      ),
    );
  }}
}}
"""

DTO_TEMPLATE = """
class {className}Dto {{
  final String id;
  final Map<String, dynamic> raw;

  {className}Dto({{required this.id, required this.raw}});

  factory {className}Dto.fromJson(Map<String, dynamic> json) {{
    return {className}Dto(
      id: json['id'] ?? '',
      raw: json,
    );
  }}
}}
"""

MAPPER_TEMPLATE = """
import '../domain/models/{snakeName}_view_model.dart';
import '../data/dtos/{snakeName}_dto.dart';

class {className}Mapper {{
  static {className}ViewModel fromDto({className}Dto dto) {{
    return {className}ViewModel(
      title: dto.raw['title'] ?? '{title}',
      metadata: dto.raw,
    );
  }}
}}
"""

# --- Logic ---

def to_snake_case(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

def to_camel_case(name):
    return ''.join(x.capitalize() or '_' for x in name.split('_'))

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

def hydrate():
    if not os.path.exists(INTENTS_PATH):
        print("❌ Intents file not found.")
        return

    with open(INTENTS_PATH, 'r') as f:
        intents = json.load(f)

    print(f"Hydrating {len(intents)} intents...")

    for intent in intents:
        enum_name = intent['enumName']
        feature_name = get_feature_group(enum_name)
        class_name = enum_name[0].upper() + enum_name[1:]
        snake_name = to_snake_case(enum_name)
        
        # Paths
        base_dir = f"{FEATURES_DIR}/{feature_name}"
        dirs = {
            "domain": f"{base_dir}/domain/models",
            "dtos": f"{base_dir}/data/dtos",
            "mappers": f"{base_dir}/data/mappers",
            "presentation": f"{base_dir}/presentation/widgets"
        }

        for d in dirs.values():
            os.makedirs(d, exist_ok=True)

        # Write Files (Only if they don't exist to avoid overwriting real code)
        files = [
            (f"{dirs['domain']}/{snake_name}_view_model.dart", VIEW_MODEL_TEMPLATE.format(className=class_name)),
            (f"{dirs['dtos']}/{snake_name}_dto.dart", DTO_TEMPLATE.format(className=class_name)),
            (f"{dirs['mappers']}/{snake_name}_mapper.dart", MAPPER_TEMPLATE.format(className=class_name, snakeName=snake_name, title=enum_name)),
            (f"{dirs['presentation']}/{snake_name}_screen.dart", SCREEN_TEMPLATE.format(className=class_name, title=enum_name, featureName=feature_name))
        ]

        for path, content in files:
            if not os.path.exists(path):
                with open(path, 'w') as f:
                    f.write(content.strip() + "\n")

    print("Hydration complete.")

if __name__ == "__main__":
    hydrate()
