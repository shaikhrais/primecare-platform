const fs = require('fs');
const path = require('path');

const premiumDir = path.join(__dirname, '../packages/primecare_ui/lib/src/screens/premium');
const registryFile = path.join(__dirname, '../packages/primecare_ui/lib/src/registry/screen_registry.dart');

// Total needed 125
const totalNeeded = 125;
let registryContent = fs.readFileSync(registryFile, 'utf8');

const importLines = [];
const widgetLines = [];

for (let i = 1; i <= totalNeeded; i++) {
  const featureName = `PremiumFeature${i}`;
  const featureDirName = `premium_feature_${i}`;
  const featurePath = path.join(premiumDir, featureDirName);
  
  if (!fs.existsSync(featurePath)) {
    fs.mkdirSync(featurePath, { recursive: true });
  }

  // View
  const viewFileName = `${featureDirName}_view.dart`;
  const viewFilePath = path.join(featurePath, viewFileName);
  const viewContent = `import 'package:flutter/material.dart';
import '${featureDirName}_controller.dart';

class ${featureName}View extends StatelessWidget {
  const ${featureName}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${featureName} View (MVC)')),
    );
  }
}
`;
  fs.writeFileSync(viewFilePath, viewContent);

  // Controller
  const controllerFileName = `${featureDirName}_controller.dart`;
  const controllerFilePath = path.join(featurePath, controllerFileName);
  const controllerContent = `class ${featureName}Controller {
  // Controller logic here
}
`;
  fs.writeFileSync(controllerFilePath, controllerContent);

  // Model
  const modelFileName = `${featureDirName}_model.dart`;
  const modelFilePath = path.join(featurePath, modelFileName);
  const modelContent = `class ${featureName}Model {
  // Model data here
}
`;
  fs.writeFileSync(modelFilePath, modelContent);

  importLines.push(`import '../screens/premium/${featureDirName}/${viewFileName}';`);
  widgetLines.push(`    'SCREEN_PREMIUM_FEATURE_${i}': const ${featureName}View(),`);
}

// Insert imports after last import
const lastImportIndex = registryContent.lastIndexOf('import ');
const nextNewLine = registryContent.indexOf('\n', lastImportIndex);
registryContent = registryContent.slice(0, nextNewLine + 1) + importLines.join('\n') + '\n' + registryContent.slice(nextNewLine + 1);

// Insert widgets into _widgetRegistry
const widgetRegistryStart = registryContent.indexOf('_widgetRegistry = {') + '_widgetRegistry = {'.length;
registryContent = registryContent.slice(0, widgetRegistryStart) + '\n' + widgetLines.join('\n') + registryContent.slice(widgetRegistryStart);

fs.writeFileSync(registryFile, registryContent);

console.log('Successfully generated 125 MVC premium screens and updated ScreenRegistry.');
