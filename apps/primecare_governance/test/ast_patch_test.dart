import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/services/ast_patch_engine.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tempDir;
  late String registryPath;
  late ASTPatchEngine engine;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('ast_patch_test');
    final libDir = Directory(p.join(tempDir.path, 'lib/core/governance'))..createSync(recursive: true);
    registryPath = p.join(libDir.path, 'screen_registry.dart');
    
    // Create a mock ScreenRegistry file
    File(registryPath).writeAsStringSync('''
import 'package:flutter/material.dart';

class ScreenMetadata {
  final String id;
  final String routePath;
  final List<String> requiredComponents;
  final dynamic lifecycleStatus;

  const ScreenMetadata({
    required this.id,
    required this.routePath,
    required this.requiredComponents,
    required this.lifecycleStatus,
  });
}

class ScreenRegistry {
  static const Map<String, ScreenMetadata> screens = {
    'existing': ScreenMetadata(
      id: 'existing',
      routePath: '/existing',
      requiredComponents: [],
      lifecycleStatus: 'backlog',
    ),
  };
}
''');

    engine = ASTPatchEngine(tempDir.path);
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  test('injectScreenConstant should add a new entry to ScreenRegistry', () async {
    final success = await engine.injectScreenConstant(
      registryPath: 'lib/core/governance/screen_registry.dart',
      className: 'ScreenRegistry',
      screenId: 'SCREEN_NEW',
      metadata: {
        'id': 'SCREEN_NEW',
        'routePath': '/new',
        'requiredComponents': ['Comp1'],
        'lifecycleStatus': 'LifecycleStatus.backlog',
      },
    );
    
    expect(success, isTrue);
    
    final content = File(registryPath).readAsStringSync();
    expect(content, contains("'SCREEN_NEW': const ScreenMetadata("));
    expect(content, contains("routePath: '/new'"));
    expect(content, contains("requiredComponents: ['Comp1']"));
  });

  test('batchInjectSwitchCases should add new cases to a switch statement', () async {
    final providerPath = p.join(tempDir.path, 'lib/core/governance/provider.dart');
    File(providerPath).writeAsStringSync('''
import 'package:flutter/material.dart';

String primecareFormProvider(String type) {
  switch (type) {
    case 'existing':
      return 'existing_provider';
    default:
      return 'default_provider';
  }
}
''');

    final success = await engine.batchInjectSwitchCases(
      [(enumValue: "'new_type'", returnValue: "'new_provider'")],
      filePath: 'lib/core/governance/provider.dart',
      variableName: 'primecareFormProvider',
    );

    expect(success, isTrue);

    final content = File(providerPath).readAsStringSync();
    expect(content, contains("case 'new_type':"));
    expect(content, contains("return 'new_provider';"));
    expect(content, contains("default:"));
  });
}
