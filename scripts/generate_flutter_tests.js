const fs = require('fs');
const path = require('path');

const CLIENT_APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_client');
const TEST_DIR = path.join(CLIENT_APP_DIR, 'integration_test');
const LIB_DIR = path.join(CLIENT_APP_DIR, 'lib');

if (!fs.existsSync(TEST_DIR)) {
    fs.mkdirSync(TEST_DIR, { recursive: true });
}

function getDartFiles(srcPath) {
    if (!fs.existsSync(srcPath)) return [];
    let results = [];
    const list = fs.readdirSync(srcPath);
    list.forEach(file => {
        const fullPath = path.join(srcPath, file);
        const stat = fs.statSync(fullPath);
        if (stat && stat.isDirectory()) { 
            results = results.concat(getDartFiles(fullPath));
        } else {
            if(file.endsWith('_screen.dart')) {
                results.push(path.basename(file));
            }
        }
    });
    return results;
}

let screens = getDartFiles(LIB_DIR);

function toPascalCase(str) {
    return str.replace(/_([a-z])/g, function (g) { return g[1].toUpperCase(); }).replace('.dart', '').replace(/^\w/, c => c.toUpperCase());
}

let testCode = `import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';

// Import all screens
`;

screens.forEach(screen => {
    testCode += `import '../lib/${screen}';\n`;
    testCode += `import '../lib/${screen.replace('.dart', '_controller.dart')}';\n`;
});

testCode += `
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('PrimeCare Client App End-to-End Tests', () {
`;

screens.forEach(screen => {
    const className = toPascalCase(screen);
    const controllerName = `${className}ControllerProvider`;
    
    testCode += `
    testWidgets('Verify ${className} renders correctly with mocked Riverpod data', (WidgetTester tester) async {
      // 1. Build the app and trigger a frame with Riverpod Mock Override
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Mocking the API response to bypass Dio networking in tests
            ${controllerName}.overrideWith(() => Mock${className}Controller()),
          ],
          child: const MaterialApp(
            home: ${className}(),
          ),
        ),
      );

      // 2. Verify initial loading state
      // expect(find.byType(CircularProgressIndicator), findsOneWidget);
      
      // 3. Let the mock async logic resolve
      await tester.pumpAndSettle();

      // 4. Verify the Scaffold renders without throwing layout exceptions
      expect(find.byType(Scaffold), findsOneWidget);
      
      // 5. Verify AppBar title exists
      expect(find.byType(AppBar), findsOneWidget);
    });
`;
});

testCode += `
  });
}
`;

// Add Mock classes at the bottom
screens.forEach(screen => {
    const className = toPascalCase(screen);
    testCode += `
class Mock${className}Controller extends ${className}Controller {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {
      'status': 'success',
      'items': [],
      'kpis': [],
    };
  }
}
`;
});

const testFilePath = path.join(TEST_DIR, 'app_test.dart');
fs.writeFileSync(testFilePath, testCode, 'utf8');

console.log(`Successfully generated integration test suite for ${screens.length} screens at ${testFilePath}`);
