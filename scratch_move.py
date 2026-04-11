import os
import re
import shutil

FEATURES_DIR = r"./packages/flutter_core/lib/features"
ADAPTERS_DIR = r"./packages/flutter_core/lib/adapters"
FLUTTER_CORE_EXPORT = r"./packages/flutter_core/lib/flutter_core.dart"

os.makedirs(ADAPTERS_DIR, exist_ok=True)

moved_features = []

for root, _, files in os.walk(FEATURES_DIR):
    for file in files:
        if file.endswith('_adapter.dart'):
            feature_name = file.replace('_adapter.dart', '')
            old_path = os.path.join(root, file)
            new_path = os.path.join(ADAPTERS_DIR, file)
            
            with open(old_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Adapt the relative imports
            # Inside the original it was inside lib/features/X/data/adapters/
            # Moving to lib/adapters/
            
            # import '../../domain/models/X_view_model.dart';
            # -> import '../features/X/domain/models/X_view_model.dart';
            content = content.replace(f"../../domain/models/", f"../features/{feature_name}/domain/models/")
            
            # import '../mappers/X_mapper.dart';
            # -> import '../features/X/data/mappers/X_mapper.dart';
            content = content.replace(f"../mappers/", f"../features/{feature_name}/data/mappers/")

            # import '../dtos/X_dto.dart';
            # -> import '../features/X/data/dtos/X_dto.dart';
            content = content.replace(f"../dtos/", f"../features/{feature_name}/data/dtos/")
            
            # Also handle potentially any config or core imports from higher up
            # old: '../../../../config' -> new: '../config'
            # (If depth was 4 levels deep in features/X/data/adapters, now depth is 1 level deep in adapters/)
            content = re.sub(r"\.\./\.\./\.\./\.\./", "../", content)
            content = re.sub(r"\.\./\.\./\.\./(?=config|network|registry|routes|theme|provider_service\.dart|dashboard_service\.dart)", "../", content)

            with open(new_path, 'w', encoding='utf-8') as f:
                f.write(content)
                
            # Remove old file
            os.remove(old_path)
            # Try to remove empty dir
            try:
                os.rmdir(root)
            except OSError:
                pass # not empty

            moved_features.append(feature_name)

# Update flutter_core.dart
with open(FLUTTER_CORE_EXPORT, "r", encoding='utf-8') as f:
    core_content = f.read()

for feature_name in moved_features:
    # Look for export 'features/xyz/data/adapters/xyz_adapter.dart';
    # Replace with export 'adapters/xyz_adapter.dart';
    core_content = core_content.replace(
        f"export 'features/{feature_name}/data/adapters/{feature_name}_adapter.dart';",
        f"export 'adapters/{feature_name}_adapter.dart';"
    )

with open(FLUTTER_CORE_EXPORT, "w", encoding='utf-8') as f:
    f.write(core_content)

print(f"Successfully moved {len(moved_features)} adapters to {ADAPTERS_DIR} and updated flutter_core.dart exports.")
