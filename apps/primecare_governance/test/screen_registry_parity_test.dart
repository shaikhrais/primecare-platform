
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';

void main() {
  test('Audit Screen Registry Parity', () async {
    final projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
    
    final blueprintPath = p.join(
      projectRoot, 
      'packages/factory_system/primecare_ui/lib/src/blueprint_seeder.dart'
    );
    final registriesDir = p.join(
      projectRoot,
      'apps/primecare_governance/lib/core/governance/registries'
    );

    PrimeLogger.info('Auditing Screen Registry Parity...');
    PrimeLogger.info('Blueprint Path: $blueprintPath');
    PrimeLogger.info('Registries Directory: $registriesDir');

    expect(File(blueprintPath).existsSync(), true, reason: 'Blueprint file missing');
    expect(Directory(registriesDir).existsSync(), true, reason: 'Registries directory missing');

    final blueprintContent = File(blueprintPath).readAsStringSync();
    final blueprintResult = parseString(content: blueprintContent);

    final blueprints = <String, List<String>>{};
    final blueprintVisitor = _BlueprintVisitor((route, components) {
      blueprints[route] = components;
    });
    blueprintResult.unit.accept(blueprintVisitor);

    final registeredScreens = <String, ({String route, List<String> components})>{};
    
    final registryFiles = Directory(registriesDir).listSync().whereType<File>().where((f) => f.path.endsWith('.dart'));
    
    for (final file in registryFiles) {
      final content = file.readAsStringSync();
      final result = parseString(content: content);
      final visitor = _ScreenRegistryMetadataVisitor((id, route, components, status) {
        registeredScreens[id] = (route: route, components: components);
      });
      result.unit.accept(visitor);
    }

    PrimeLogger.info('Found ${blueprints.length} blueprints.');
    PrimeLogger.info('Found ${registeredScreens.length} total registered screens across all registries.');

    final missingRoutes = <String>[];
    for (final blueprintRoute in blueprints.keys) {
      if (blueprintRoute == 'DYNAMIC_ROLE_DASHBOARD') continue; // Skip generic placeholder
      
      bool found = false;
      for (final screen in registeredScreens.values) {
        if (screen.route == blueprintRoute) {
          found = true;
          break;
        }
      }
      if (!found) {
        missingRoutes.add(blueprintRoute);
      }
    }

    if (missingRoutes.isEmpty) {
      PrimeLogger.info('SUCCESS: All specific blueprint routes are registered.');
    } else {
      PrimeLogger.warning('FAILURE: Missing ${missingRoutes.length} route registrations:');
      for (final r in missingRoutes) {
        PrimeLogger.warning(' - $r');
      }
    }

    // Structural check
    int driftCount = 0;
    for (final blueprintEntry in blueprints.entries) {
        final route = blueprintEntry.key;
        if (route == 'DYNAMIC_ROLE_DASHBOARD') continue;
        
        final required = blueprintEntry.value;

        for (final screen in registeredScreens.values) {
            if (screen.route == route) {
                final implemented = screen.components;
                final missingComps = required.where((c) => !implemented.contains(c)).toList();
                if (missingComps.isNotEmpty) {
                    PrimeLogger.warning('DRIFT: Route $route is missing components: $missingComps');
                    driftCount++;
                }
            }
        }
    }
    if (driftCount == 0) {
        PrimeLogger.info('SUCCESS: No structural drift detected.');
    } else {
        PrimeLogger.warning('FAILURE: Found $driftCount screens with structural drift.');
    }
  });
}

class _BlueprintVisitor extends RecursiveAstVisitor<void> {
  final void Function(String route, List<String> components) onBlueprint;
  _BlueprintVisitor(this.onBlueprint);

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.staticType?.getDisplayString() == 'AuditorBlueprint' ||
        node.constructorName.type.name.lexeme == 'AuditorBlueprint') {
      
      String? route;
      final components = <String>[];

      for (final arg in node.argumentList.arguments) {
        if (arg is NamedExpression) {
          final name = arg.name.label.name;
          if (name == 'route') {
            final expr = arg.expression;
            if (expr is StringLiteral) {
              route = expr.stringValue;
            }
          } else if (name == 'requiredComponents') {
            final expr = arg.expression;
            if (expr is ListLiteral) {
              for (final element in expr.elements) {
                if (element is InstanceCreationExpression) {
                  for (final compArg in element.argumentList.arguments) {
                    if (compArg is NamedExpression && compArg.name.label.name == 'label') {
                      final labelExpr = compArg.expression;
                      if (labelExpr is StringLiteral) {
                        components.add(labelExpr.stringValue ?? '');
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      if (route != null) {
        onBlueprint(route, components);
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}

class _ScreenRegistryMetadataVisitor extends RecursiveAstVisitor<void> {
  final void Function(String id, String route, List<String> components, String? status) onMetadata;
  _ScreenRegistryMetadataVisitor(this.onMetadata);

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    final value = node.value;
    if (value is InstanceCreationExpression) {
      String? route;
      String? status;
      final components = <String>[];

      for (final arg in value.argumentList.arguments) {
        if (arg is NamedExpression) {
          final name = arg.name.label.name;
          if (name == 'routePath') {
            final expr = arg.expression;
            if (expr is StringLiteral) {
              route = expr.stringValue;
            }
          } else if (name == 'lifecycleStatus') {
            final expr = arg.expression;
            status = expr.toString();
          } else if (name == 'implementedComponents' || name == 'pendingComponents') {
            final expr = arg.expression;
            if (expr is ListLiteral) {
              for (final element in expr.elements) {
                if (element is StringLiteral) {
                  components.add(element.stringValue ?? '');
                }
              }
            }
          }
        }
      }

      if (route != null) {
        final key = node.key;
        String id = 'UNKNOWN';
        if (key is StringLiteral) id = key.stringValue ?? 'UNKNOWN';
        onMetadata(id, route, components, status);
      }
    }
    super.visitMapLiteralEntry(node);
  }
}
