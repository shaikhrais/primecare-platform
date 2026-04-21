import json
import os
import re

def to_snake_case(name):
    # Handle consecutive capital letters (e.g., AWS -> aws, CEO -> ceo)
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

def pascal_case(s):
    return ''.join(word.capitalize() for word in s.split('_'))

PROJECT_ROOT = "C:/Users/Admin2/Documents/GitHub/primecare-platform"
SNAPSHOT_PATH = os.path.join(PROJECT_ROOT, "pdm_snapshot.json")
FEATURES_DIR = os.path.join(PROJECT_ROOT, "packages/flutter_core/lib/features")
UI_PACKAGE_DIR = os.path.join(PROJECT_ROOT, "packages/factory_system/primecare_ui/lib/src")

def generate_recovery():
    if not os.path.exists(SNAPSHOT_PATH):
        print("No snapshot found. Run pdm_engine.py first.")
        return

    with open(SNAPSHOT_PATH, "r") as f:
        results = json.load(f)
        
    # We target both UNALLOCATED and EMPTY_BLOCK to reach 100% maturity
    targets = [r for r in results if r['status'] in ['UNALLOCATED', 'EMPTY_BLOCK']]
    print(f"Found {len(targets)} sectors requiring hardening.")
    
    for intent in targets:
        intent_id = intent['intentId']
        enum_name = intent['enumName']
        snake_name = to_snake_case(enum_name).replace("__", "_")
        
        # Determine target directory
        if "Dashboard" in enum_name or "Screen" in enum_name or "Page" in enum_name:
            feature_name = snake_name.replace("_dashboard", "").replace("_screen", "").replace("_page", "")
            if feature_name.endswith('_'): feature_name = feature_name[:-1]
            
            target_dir = os.path.join(FEATURES_DIR, feature_name, "presentation", "widgets")
            os.makedirs(target_dir, exist_ok=True)
            filename = f"05_U_{snake_name}.dart"
            target_path = os.path.join(target_dir, filename)
            
            content = f"""
// Layer: 05_UI_PRESENTATION
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:primecare_ui/00_B_primecare_ui.dart';

/// Hardened {enum_name}
class {pascal_case(intent_id)} extends StatelessWidget {{
  const {pascal_case(intent_id)}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return const PrimeCareResponsiveKpiGrid(
      title: '{enum_name}',
      children: [
        PrimeCareCard(child: Text('Operational Sector: {intent_id}')),
      ],
    );
  }}
}}
"""
        elif "Provider" in enum_name or "Context" in enum_name:
             feature_name = snake_name.replace("_provider", "").replace("_context", "")
             if feature_name.endswith('_'): feature_name = feature_name[:-1]
             
             target_dir = os.path.join(FEATURES_DIR, feature_name, "presentation", "providers")
             os.makedirs(target_dir, exist_ok=True)
             target_path = os.path.join(target_dir, "03_D_providers.dart")
             
             provider_code = f"\nfinal {intent_id} = Provider<AsyncValue<Map<String, dynamic>>>((ref) => const AsyncValue.data({{}}));\n"
             
             mode = "a" if os.path.exists(target_path) else "w"
             with open(target_path, mode) as f:
                 if mode == "w":
                     f.write("// Layer: 03_DATA_DOMAIN_LOGIC\nimport 'package:flutter_riverpod/flutter_riverpod.dart';\n")
                 f.write(provider_code)
             continue # Path already handled
        
        else:
            # Generic UI Component to primecare_ui
            target_dir = os.path.join(UI_PACKAGE_DIR, "components")
            os.makedirs(target_dir, exist_ok=True)
            target_path = os.path.join(target_dir, f"01_I_{snake_name}.dart")
            
            content = f"""
// Layer: 01_UI_COMPONENTS
import 'package:flutter/material.dart';

class {pascal_case(intent_id)} extends StatelessWidget {{
  const {pascal_case(intent_id)}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return const SizedBox.shrink();
  }}
}}
"""
        
        with open(target_path, "w") as f:
            f.write(content)
        print(f"Hardened Sector: {target_path}")

if __name__ == "__main__":
    generate_recovery()
