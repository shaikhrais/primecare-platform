import os
import shutil

OLD_ADAPTERS_DIR = r"./packages/flutter_core/lib/adapters"
NEW_ADAPTERS_DIR = r"./packages/primecare_adapters/lib/src/adapters"
PRIMECARE_ADAPTERS_EXPORT = r"./packages/primecare_adapters/lib/primecare_adapters.dart"
FLUTTER_CORE_EXPORT = r"./packages/flutter_core/lib/flutter_core.dart"

os.makedirs(NEW_ADAPTERS_DIR, exist_ok=True)

moved_adapters = []

if os.path.exists(OLD_ADAPTERS_DIR):
    for file in os.listdir(OLD_ADAPTERS_DIR):
        if file.endswith('_adapter.dart'):
            feature_name = file.replace('_adapter.dart', '')
            old_path = os.path.join(OLD_ADAPTERS_DIR, file)
            new_path = os.path.join(NEW_ADAPTERS_DIR, file)
            
            with open(old_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Now we must change relative imports back to absolute imports via flutter_core package!
            # It was recently: import '../features/XYZ/domain/models/XYZ_view_model.dart';
            # Now it should be: import 'package:flutter_core/features/XYZ/domain/models/XYZ_view_model.dart';
            # Note: Previously we set them to `../features/...` in the previous step. So let's replace `../features/` with `package:flutter_core/features/`
            
            content = content.replace("import '../features/", "import 'package:flutter_core/features/")
            
            with open(new_path, 'w', encoding='utf-8') as f:
                f.write(content)
                
            os.remove(old_path)
            moved_adapters.append(feature_name)

# Expose them in primecare_adapters.dart
exports = []
for adapter in moved_adapters:
    exports.append(f"export 'src/adapters/{adapter}_adapter.dart';")

with open(PRIMECARE_ADAPTERS_EXPORT, "w", encoding='utf-8') as f:
    f.write("// Master export for primecare_adapters\n")
    f.write("\n".join(exports))
    f.write("\n")

# Remove exports from flutter_core.dart
with open(FLUTTER_CORE_EXPORT, "r", encoding='utf-8') as f:
    core_content = f.read()

lines = core_content.split('\n')
new_lines = [l for l in lines if "export 'adapters/" not in l and "export 'features/" not in l or not l.strip().endswith("_adapter.dart';")]

with open(FLUTTER_CORE_EXPORT, "w", encoding='utf-8') as f:
    f.write('\n'.join(new_lines))

print(f"Successfully moved {len(moved_adapters)} to primecare_adapters and configured exports.")
