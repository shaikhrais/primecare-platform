import os
import re

# This script automates the /scale-ui-adapters workflow across the PrimeCare codebase.
# It parses existing dashboard screens and rapidly generates the Data Binding Architecture:
# - ViewModels
# - DTOs
# - Mappers
# - Adapters

SCREENS_DIR = r".\packages\flutter_ui\lib\src\screens\offices"
FEATURES_DIR = r".\packages\flutter_core\lib\features"
FLUTTER_CORE_EXPORT = r".\packages\flutter_core\lib\flutter_core.dart"

def to_camel_case(snake_str):
    components = snake_str.split('_')
    return components[0] + ''.join(x.title() for x in components[1:])

def to_pascal_case(snake_str):
    components = snake_str.split('_')
    return ''.join(x.title() for x in components)

created_features = []

for root, _, files in os.walk(SCREENS_DIR):
    for file in files:
        if file.endswith('_dashboard_screen.dart'):
            feature_name = file.replace('_screen.dart', '')
            feature_path = os.path.join(FEATURES_DIR, feature_name)
            
            # Skip if already exists (e.g. franchise_owner_dashboard)
            if os.path.exists(feature_path):
                continue
                
            os.makedirs(os.path.join(feature_path, "domain", "models"), exist_ok=True)
            os.makedirs(os.path.join(feature_path, "data", "dtos"), exist_ok=True)
            os.makedirs(os.path.join(feature_path, "data", "mappers"), exist_ok=True)
            os.makedirs(os.path.join(feature_path, "data", "adapters"), exist_ok=True)
            
            pascal_name = to_pascal_case(feature_name)
            camel_name = to_camel_case(feature_name)
            
            # --- VIEW MODEL ---
            vm_code = f"""class {pascal_name}ViewModel {{
  final List<dynamic> kpis;
  final List<dynamic> recentActivity;

  const {pascal_name}ViewModel({{
    this.kpis = const [],
    this.recentActivity = const [],
  }});
}}
"""
            with open(os.path.join(feature_path, "domain", "models", f"{feature_name}_view_model.dart"), "w") as f:
                f.write(vm_code)

            # --- DTO ---
            dto_code = f"""class {pascal_name}Dto {{
  final List<dynamic> rawKpis;

  {pascal_name}Dto({{required this.rawKpis}});

  factory {pascal_name}Dto.fromJson(Map<String, dynamic> json) {{
    return {pascal_name}Dto(rawKpis: json['kpis'] ?? []);
  }}
}}
"""
            with open(os.path.join(feature_path, "data", "dtos", f"{feature_name}_dto.dart"), "w") as f:
                f.write(dto_code)
                
            # --- MAPPER ---
            mapper_code = f"""import '../../domain/models/{feature_name}_view_model.dart';
import '../dtos/{feature_name}_dto.dart';

class {pascal_name}Mapper {{
  static {pascal_name}ViewModel fromApi({pascal_name}Dto dto) {{
    return {pascal_name}ViewModel(kpis: dto.rawKpis);
  }}

  static {pascal_name}ViewModel fromMock(Map<String, dynamic> mock) {{
    return const {pascal_name}ViewModel();
  }}
}}
"""
            with open(os.path.join(feature_path, "data", "mappers", f"{feature_name}_mapper.dart"), "w") as f:
                f.write(mapper_code)

            # --- ADAPTER ---
            adapter_code = f"""import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/{feature_name}_view_model.dart';
import '../mappers/{feature_name}_mapper.dart';

final {camel_name}AdapterProvider = FutureProvider<{pascal_name}ViewModel>((ref) async {{
  return {pascal_name}Mapper.fromMock({{}});
}});
"""
            with open(os.path.join(feature_path, "data", "adapters", f"{feature_name}_adapter.dart"), "w") as f:
                f.write(adapter_code)
                
            created_features.append(feature_name)

# Inject exports
if created_features:
    with open(FLUTTER_CORE_EXPORT, "r") as f:
        core_content = f.read()

    new_exports = []
    for fn in created_features:
        new_exports.append(f"export 'features/{fn}/data/adapters/{fn}_adapter.dart';")
        new_exports.append(f"export 'features/{fn}/domain/models/{fn}_view_model.dart';")

    core_content += "\n// Auto-scaled adapters\n" + "\n".join(new_exports) + "\n"

    with open(FLUTTER_CORE_EXPORT, "w") as f:
        f.write(core_content)

print(f"Generated UI Adapters for {len(created_features)} features: {created_features}")
