// Layer: 05_REGISTRY_GOVERNANCE
// Path: apps/primecare_governance/lib/governance/services/cross_subsystem_auditor.dart

import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

/// Model for an audit failure in cross-subsystem consistency.
class AuditIssue {
  final String subsystem;
  final String registry;
  final String issue;
  final String suggestion;
  final bool autoRemediable;
  final Map<String, dynamic> metadata;

  AuditIssue({
    required this.subsystem,
    required this.registry,
    required this.issue,
    required this.suggestion,
    this.autoRemediable = false,
    this.metadata = const {},
  });
}

/// Orchestrates architectural consistency audits across the PrimeCare platform.
/// Specifically focuses on parity between 'primecare_ui' registries and 'primecare_governance' expectations.
class CrossSubsystemAuditor {
  final String projectRoot;

  CrossSubsystemAuditor({required this.projectRoot});

  /// Audits the parity between PrimeCareForm enum and PrimeCareFormProvider switch-cases.
  Future<List<AuditIssue>> auditFormProviderParity() async {
    final List<AuditIssue> issues = [];
    
    final enumPath = p.join(
      projectRoot, 
      'packages/flutter_core/lib/models/platform_types.dart'
    );
    final providerPath = p.join(
      projectRoot,
      'packages/flutter_core/lib/src/registry/dynamic_adapter_resolver.dart'
    );

    if (!File(enumPath).existsSync() || !File(providerPath).existsSync()) {
      return [
        AuditIssue(
          subsystem: 'primecare_ui',
          registry: 'FormProvider',
          issue: 'Registry files missing',
          suggestion: 'Ensure the primecare_ui package is correctly structured.',
        )
      ];
    }

    try {
      final enumContent = File(enumPath).readAsStringSync();
      final providerContent = File(providerPath).readAsStringSync();

      final enumResult = parseString(content: enumContent);
      final providerResult = parseString(content: providerContent);

      final enumValues = <String>{};
      final visitor = _EnumVisitor((name) => enumValues.add(name));
      enumResult.unit.accept(visitor);

      final providerCases = <String>{};
      final providerVisitor = _SwitchCaseVisitor((name) => providerCases.add(name));
      providerResult.unit.accept(providerVisitor);

      const relativeProviderPath = 'packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_provider.dart';
      
      // Check for missing mappings
      for (final value in enumValues) {
        if (!providerCases.contains(value)) {
          issues.add(AuditIssue(
            subsystem: 'primecare_ui',
            registry: 'PrimeCareFormProvider',
            issue: 'Missing binding for Form: $value',
            suggestion: 'Run ASTPatchEngine to inject missing switch-case.',
            autoRemediable: true,
            metadata: {
              'type': 'missing_form_provider',
              'form': value,
              'targetPath': 'packages/flutter_core/lib/src/registry/dynamic_adapter_resolver.dart',
            },
          ));
        }
      }
    } catch (e) {
      issues.add(AuditIssue(
        subsystem: 'primecare_governance',
        registry: 'Auditor',
        issue: 'Audit process failed: $e',
        suggestion: 'Check file permissions and AST parser compatibility.',
      ));
    }

    return issues;
  }

  /// Audits if all governance-defined screens exist in the ScreenRegistry.
  Future<List<AuditIssue>> auditScreenRegistryParity() async {
    final List<AuditIssue> issues = [];

    // Adaptive path resolution
    String root = projectRoot;
    if (File(p.join(root, 'pubspec.yaml')).existsSync() && 
        !Directory(p.join(root, 'packages')).existsSync()) {
      // We are likely in an app directory, workspace root is two levels up
      root = p.normalize(p.join(root, '../..'));
    }

    final blueprintPath = p.normalize(p.join(
      root,
      'packages/factory_system/primecare_ui/lib/src/blueprint_seeder.dart'
    ));
    final screenRegistryPath = p.normalize(p.join(
      root,
      'apps/primecare_governance/lib/core/governance/screen_registry.dart'
    ));

    if (!File(blueprintPath).existsSync() || !File(screenRegistryPath).existsSync()) {
      return [
        AuditIssue(
          subsystem: 'primecare_governance',
          registry: 'ScreenRegistry',
          issue: 'Registry or Blueprint files missing',
          suggestion: 'Ensure both BlueprintSeeder and ScreenRegistry exist.',
        )
      ];
    }

    try {
      final blueprintContent = File(blueprintPath).readAsStringSync();
      final registryContent = File(screenRegistryPath).readAsStringSync();

      final blueprintResult = parseString(content: blueprintContent);
      final registryResult = parseString(content: registryContent);

      final blueprints = <String, List<String>>{};
      final blueprintVisitor = _BlueprintVisitor((route, components) {
        blueprints[route] = components;
      });
      blueprintResult.unit.accept(blueprintVisitor);

      // --- ADVANCED PARITY: Handle Dynamic/Interpolated Blueprints ---
      // The AST visitor misses interpolated strings like '/business-development/$region-$domain-regional-view'
      // We perform a targeted regex sweep for these known architectural patterns.
      final bdLoopRegex = RegExp(r"route:\s*'/business-development/\$region-\$pathDomain-regional-view'");
      if (bdLoopRegex.hasMatch(blueprintContent)) {
        final regions = ['ontario', 'usa', 'quebec', 'bc', 'alberta', 'maritimes'];
        final domains = ['finance', 'clinical', 'operations', 'hr', 'marketing', 'compliance'];
        for (final r in regions) {
          for (final d in domains) {
            final route = '/business-development/$r-$d-regional-view';
            // Only add if not already caught by AST (unlikely for interpolated)
            if (!blueprints.containsKey(route)) {
              blueprints[route] = ["Aura HUD", "Regional Heatmap", "Site Compliance Grid", "Territory KPI HUD"];
            }
          }
        }
      }

      final registeredScreens = <String, ({String route, List<String> components, String? status})>{};
      final registryVisitor = _ScreenRegistryMetadataVisitor((id, route, components, status) {
        registeredScreens[id] = (route: route, components: components, status: status);
      });
      registryResult.unit.accept(registryVisitor);

      // 1. Check for missing screens (Route Parity)
      for (final blueprintEntry in blueprints.entries) {
        final blueprintRoute = blueprintEntry.key;
        final requiredComponents = blueprintEntry.value;

        bool routeFound = false;
        String? foundId;
        for (final screenEntry in registeredScreens.entries) {
          if (screenEntry.value.route == blueprintRoute) {
            routeFound = true;
            foundId = screenEntry.key;
            break;
          }
        }

        if (!routeFound) {
          issues.add(AuditIssue(
            subsystem: 'primecare_governance',
            registry: 'ScreenRegistry',
            issue: 'Blueprint route not registered: $blueprintRoute',
            suggestion: 'Add screen metadata to ScreenRegistry for this route.',
            autoRemediable: true,
            metadata: {
              'type': 'missing_screen_registration',
              'route': blueprintRoute,
              'requiredComponents': requiredComponents,
            },
          ));
        } else if (foundId != null) {
      // 2. Check for missing components (Structural Parity)
          final implementedComponents = registeredScreens[foundId]!.components;
          final missingComponents = requiredComponents
              .where((c) => !implementedComponents.contains(c))
              .toList();

          if (missingComponents.isNotEmpty) {
            issues.add(AuditIssue(
              subsystem: 'primecare_governance',
              registry: 'ScreenRegistry',
              issue: 'Structural Drift in $foundId: Missing components $missingComponents',
              suggestion: 'Update implementedComponents in ScreenRegistry.',
              autoRemediable: true,
              metadata: {
                'type': 'structural_drift',
                'screenId': foundId,
                'route': blueprintRoute,
                'missing': missingComponents,
              },
            ));
          }
        }
      }

      // 3. Reverse Check: Registry entries missing from Blueprint (Legacy detection)
      for (final screenId in registeredScreens.keys) {
        final screenData = registeredScreens[screenId]!;
        final screenRoute = screenData.route;
        final screenStatus = screenData.status;

        if (!blueprints.containsKey(screenRoute) && screenStatus != 'LifecycleStatus.legacy') {
          issues.add(AuditIssue(
            subsystem: 'primecare_governance',
            registry: 'ScreenRegistry',
            issue: 'Untracked registration: $screenId ($screenRoute)',
            suggestion: 'Flag this screen as legacy or remove if no longer needed.',
            autoRemediable: true,
            metadata: {
              'type': 'untracked_registration',
              'screenId': screenId,
            },
          ));
        }
      }

    } catch (e) {
      issues.add(AuditIssue(
        subsystem: 'primecare_governance',
        registry: 'Auditor',
        issue: 'Screen registry audit failed: $e',
        suggestion: 'Verify AST parser compatibility with modern Dart syntax.',
      ));
    }

    return issues;
  }
}

class _EnumVisitor extends RecursiveAstVisitor<void> {
  final void Function(String) onValue;
  _EnumVisitor(this.onValue);

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    if (node.name.lexeme == 'PrimeCareForm') {
      for (final constant in node.constants) {
        // Skip legacy forms for now if needed, or include them
        onValue(constant.name.lexeme);
      }
    }
    super.visitEnumDeclaration(node);
  }
}

class _SwitchCaseVisitor extends RecursiveAstVisitor<void> {
  final void Function(String) onCase;
  _SwitchCaseVisitor(this.onCase);

  @override
  void visitSwitchCase(SwitchCase node) {
    _handleExpression(node.expression);
    super.visitSwitchCase(node);
  }

  @override
  void visitSwitchPatternCase(SwitchPatternCase node) {
    final pattern = node.guardedPattern.pattern;
    if (pattern is ConstantPattern) {
      _handleExpression(pattern.expression);
    }
    super.visitSwitchPatternCase(node);
  }

  void _handleExpression(Expression expression) {
    if (expression is PrefixedIdentifier) {
      if (expression.prefix.name == 'PrimeCareForm') {
        onCase(expression.identifier.name);
      }
    }
  }
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
                  // BlueprintComponent
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
    final key = node.key;
    if (key is SimpleStringLiteral) {
      final id = key.value;
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
              status = expr.toString(); // e.g. LifecycleStatus.legacy
            } else if (name == 'implementedComponents') {
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
          onMetadata(id, route, components, status);
        }
      }
    }
    super.visitMapLiteralEntry(node);
  }
}

