import 'dart:convert';
import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

/// A self-contained hydration script that uses the analyzer to inject screen constants
/// without importing any Flutter or project-specific code.
void main() async {
  print('--- Starting Pure AST Registry Hydration ---');

  final projectRoot = 'c:/Users/Admin2/Documents/GitHub/primecare-platform';
  final blueprintsPath = p.join(projectRoot, 'architectural_blueprints.json');

  if (!File(blueprintsPath).existsSync()) {
    print('Error: blueprints.json not found at $blueprintsPath');
    return;
  }

  final blueprints = jsonDecode(File(blueprintsPath).readAsStringSync());
  final categories = blueprints['categories'] as Map<String, dynamic>;

  int totalSuccess = 0;
  int totalSkipped = 0;
  int totalErrors = 0;

  for (final category in categories.entries) {
    final categoryName = category.key;
    final screens = category.value as List<dynamic>;
    final registryPath = _getRegistryPath(projectRoot, categoryName);
    final className = _getClassName(categoryName);

    print('Processing category: $categoryName -> $className ($registryPath)');

    if (!File(registryPath).existsSync()) {
      print(
        'Warning: Registry file not found: $registryPath. Skipping category.',
      );
      continue;
    }

    for (final screen in screens) {
      final title = screen['name'] as String;
      // Clean screenId
      final screenId =
          'SCREEN_${title.toUpperCase().replaceAll(' ', '_').replaceAll('-', '_').replaceAll('(', '').replaceAll(')', '').replaceAll('&', 'AND').replaceAll('/', '_').replaceAll('.', '')}';

      final roles = _suggestRoles(categoryName, title);

      final result = await _injectIfMissing(
        registryPath: registryPath,
        className: className,
        screenId: screenId,
        metadata: {
          'id': screenId,
          'featureName': title,
          'routePath': _generateRoute(categoryName, title),
          'title': title,
          'description': (screen['intent'] ?? '').toString().replaceAll(
            '\n',
            ' ',
          ),
          'office': categoryName,
          'role': roles.first,
          'allowedRoles': roles,
          'lifecycleStatus': 'LifecycleStatus.backlog',
          'icon': 'Icons.auto_awesome_mosaic',
          'pendingComponents': screen['components'] ?? [],
        },
      );

      if (result == 'success')
        totalSuccess++;
      else if (result == 'skipped')
        totalSkipped++;
      else
        totalErrors++;
    }
  }

  print('\n--- HYDRATION COMPLETE ---');
  print('Injected: $totalSuccess');
  print('Skipped (Existing): $totalSkipped');
  print('Errors: $totalErrors');
}

String _getRegistryPath(String root, String category) {
  final base = 'apps/primecare_governance/lib/core/governance/registries';
  switch (category) {
    case 'Clinical':
      return p.join(root, base, 'clinical_registry.dart');
    case 'Corporate':
      return p.join(root, base, 'corporate_registry.dart');
    case 'Franchise':
      return p.join(root, base, 'franchise_registry.dart');
    case 'Business Development':
      return p.join(root, base, 'business_development_registry.dart');
    case 'Marketing':
      return p.join(root, base, 'marketing_registry.dart');
    case 'Infrastructure & Admin':
      return p.join(root, base, 'admin_infrastructure_registry.dart');
    case 'Workflows & Forms':
      return p.join(root, base, 'workflows_forms_registry.dart');
    case 'Support':
      return p.join(root, base, 'support_registry.dart');
    default:
      return p.join(root, base, 'operational_registry.dart');
  }
}

String _getClassName(String category) {
  switch (category) {
    case 'Clinical':
      return 'ClinicalRegistry';
    case 'Corporate':
      return 'CorporateRegistry';
    case 'Franchise':
      return 'FranchiseRegistry';
    case 'Business Development':
      return 'BusinessDevelopmentRegistry';
    case 'Marketing':
      return 'MarketingRegistry';
    case 'Infrastructure & Admin':
      return 'AdminInfrastructureRegistry';
    case 'Workflows & Forms':
      return 'WorkflowsFormsRegistry';
    case 'Support':
      return 'SupportRegistry';
    default:
      return 'OperationalRegistry';
  }
}

String _generateRoute(String category, String title) {
  final cleanCat = category
      .toLowerCase()
      .replaceAll(' ', '-')
      .replaceAll('&', 'and');
  final cleanTitle = title
      .toLowerCase()
      .replaceAll(' ', '-')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('&', 'and')
      .replaceAll('/', '-')
      .replaceAll('.', '');
  return '/$cleanCat/$cleanTitle';
}

List<String> _suggestRoles(String category, String title) {
  if (category == 'Clinical') return ['Clinician', 'RN', 'MD'];
  if (category == 'Corporate') return ['Admin', 'Executive'];
  if (category == 'Infrastructure & Admin')
    return ['SysAdmin', 'SecurityOfficer'];
  if (category == 'Workflows & Forms') return ['Staff', 'Client'];
  return ['Staff'];
}

Future<String> _injectIfMissing({
  required String registryPath,
  required String className,
  required String screenId,
  required Map<String, dynamic> metadata,
}) async {
  final file = File(registryPath);
  String content = await file.readAsString();

  if (content.contains("'$screenId':")) {
    return 'skipped';
  }

  try {
    final result = parseString(content: content);
    final visitor = _RegistryVisitor(className, 'screens');
    result.unit.accept(visitor);

    if (visitor.targetMap == null) {
      print(
        '  Error: Could not find "screens" map in $className at $registryPath',
      );
      return 'error';
    }

    final buffer = StringBuffer();
    buffer.writeln("    '$screenId': const ScreenMetadata(");
    metadata.forEach((key, value) {
      if (value is String) {
        if (value.startsWith('LifecycleStatus.') ||
            value.startsWith('Icons.')) {
          buffer.writeln("      $key: $value,");
        } else {
          buffer.writeln("      $key: '${value.replaceAll("'", "\\'")}',");
        }
      } else if (value is List) {
        final listStr = value
            .map((e) => "'${e.toString().replaceAll("'", "\\'")}'")
            .join(', ');
        buffer.writeln("      $key: [$listStr],");
      }
    });
    buffer.writeln("    ),");

    final offset = visitor.targetMap!.rightBracket.offset;
    final updatedContent =
        content.substring(0, offset) +
        buffer.toString() +
        content.substring(offset);

    await file.writeAsString(updatedContent);
    return 'success';
  } catch (e) {
    print('  Exception processing $screenId: $e');
    return 'error';
  }
}

class _RegistryVisitor extends RecursiveAstVisitor<void> {
  final String className;
  final String mapName;
  ClassDeclaration? registryClass;
  SetOrMapLiteral? targetMap;

  _RegistryVisitor(this.className, this.mapName);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (node.name.lexeme == className) {
      registryClass = node;
      super.visitClassDeclaration(node);
    }
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    if (registryClass != null) {
      for (final variable in node.fields.variables) {
        if (variable.name.lexeme == mapName) {
          final initializer = variable.initializer;
          if (initializer is SetOrMapLiteral) {
            targetMap = initializer;
          }
        }
      }
    }
    super.visitFieldDeclaration(node);
  }
}
