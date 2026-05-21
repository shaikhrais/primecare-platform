const fs = require('fs');
const path = require('path');

const UI_PACKAGE_PATH = path.join(__dirname, '..', 'packages', 'primecare_ui', 'lib', 'src', 'screens');
const PREMIUM_DIR = path.join(UI_PACKAGE_PATH, 'premium');
const ROLES_DIR = path.join(UI_PACKAGE_PATH, 'roles');

// Helper to convert snake_case to PascalCase
const toPascalCase = (str) => {
  return str.split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join('');
};

function generateLogicFiles() {
  if (!fs.existsSync(ROLES_DIR)) return;

  const roles = fs.readdirSync(ROLES_DIR);
  for (const role of roles) {
    const rolePath = path.join(ROLES_DIR, role);
    if (!fs.statSync(rolePath).isDirectory()) continue;

    const frequencies = fs.readdirSync(rolePath);
    for (const freq of frequencies) {
      const freqPath = path.join(rolePath, freq);
      if (!fs.statSync(freqPath).isDirectory()) continue;

      const features = fs.readdirSync(freqPath);
      for (const feature of features) {
        const featurePath = path.join(freqPath, feature);
        if (!fs.statSync(featurePath).isDirectory()) continue;

        const className = toPascalCase(feature);

        // Generate Controller
        const controllerPath = path.join(featurePath, `${feature}_controller.dart`);
        if (!fs.existsSync(controllerPath)) {
          fs.writeFileSync(controllerPath, `
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '${feature}_service.dart';

part '${feature}_controller.g.dart';

@riverpod
class ${className}Controller extends _$${className}Controller {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  Future<void> performAction() async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(${feature}ServiceProvider);
      await service.executeLogic();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
`);
        }

        // Generate Service
        const servicePath = path.join(featurePath, `${feature}_service.dart`);
        if (!fs.existsSync(servicePath)) {
          fs.writeFileSync(servicePath, `
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${feature}_service.g.dart';

@riverpod
${className}Service ${feature}Service(${className}ServiceRef ref) {
  return ${className}Service();
}

class ${className}Service {
  Future<void> executeLogic() async {
    // TODO: Implement complex business logic for ${className}
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
`);
        }
      }
    }
  }
  console.log('Logic layers generated for all role features.');
}

function cleanupUnused() {
  if (!fs.existsSync(PREMIUM_DIR)) return;
  const features = fs.readdirSync(PREMIUM_DIR);
  let deletedCount = 0;
  for (const feature of features) {
    const featurePath = path.join(PREMIUM_DIR, feature);
    if (fs.statSync(featurePath).isDirectory() && feature.startsWith('premium_feature_')) {
      fs.rmSync(featurePath, { recursive: true, force: true });
      deletedCount++;
    }
  }
  console.log(`Cleaned up ${deletedCount} unused premium screens.`);
}

generateLogicFiles();
cleanupUnused();
