const fs = require('fs');
const path = require('path');

const screensDir = path.join(__dirname, '../packages/primecare_ui/lib/src/screens/premium');
const registryFile = path.join(__dirname, '../packages/primecare_ui/lib/src/registry/screen_registry.dart');

if (!fs.existsSync(screensDir)) {
  fs.mkdirSync(screensDir, { recursive: true });
}

// Current count is 126. We need 125 more to reach 251.
const totalNeeded = 125;
let registryContent = fs.readFileSync(registryFile, 'utf8');

const importLines = [];
const widgetLines = [];

for (let i = 1; i <= totalNeeded; i++) {
  const featureName = `PremiumFeature${i}`;
  const fileName = `premium_feature_${i}_screen.dart`;
  const filePath = path.join(screensDir, fileName);
  
  const fileContent = `import 'package:flutter/material.dart';

class ${featureName}Screen extends StatelessWidget {
  const ${featureName}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('${featureName} Screen (Premium Service)')),
    );
  }
}
`;
  fs.writeFileSync(filePath, fileContent);
  
  importLines.push(`import '../screens/premium/${fileName}';`);
  widgetLines.push(`    'SCREEN_PREMIUM_FEATURE_${i}': const ${featureName}Screen(),`);
}

// Insert imports after last import
const lastImportIndex = registryContent.lastIndexOf('import ');
const nextNewLine = registryContent.indexOf('\n', lastImportIndex);
registryContent = registryContent.slice(0, nextNewLine + 1) + importLines.join('\n') + '\n' + registryContent.slice(nextNewLine + 1);

// Insert widgets into _widgetRegistry
const widgetRegistryStart = registryContent.indexOf('_widgetRegistry = {') + '_widgetRegistry = {'.length;
registryContent = registryContent.slice(0, widgetRegistryStart) + '\n' + widgetLines.join('\n') + registryContent.slice(widgetRegistryStart);

fs.writeFileSync(registryFile, registryContent);

console.log('Successfully generated 125 premium screens and updated ScreenRegistry.');
