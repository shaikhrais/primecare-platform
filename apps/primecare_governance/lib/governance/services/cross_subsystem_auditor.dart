// Layer: 05_REGISTRY_GOVERNANCE
// Path: apps/primecare_governance/lib/governance/services/cross_subsystem_auditor.dart

import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart' show Size;
import 'package:flutter_core/models/api_metadata.dart';
import 'package:flutter_core/models/screen_metadata.dart';
import '../../core/governance/registries/core_governance_registry.dart';
import '../../core/governance/registries/api_governance_registry.dart';

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

  /// Runs the full suite of cross-subsystem audits.
  Future<List<AuditIssue>> runFullAuditSuite({
    bool onlyFailed = false,
  }) async {
    final allIssues = <AuditIssue>[];

    allIssues.addAll(await auditFormProviderParity());
    allIssues.addAll(await auditApiParity());
    // allIssues.addAll(await auditRegistryDrift());
    // allIssues.addAll(await auditAssetParity());

    if (onlyFailed) {
      // By definition, all items in 'issues' are failures/drift detections.
      // If we wanted to include 'PASSED' results, we would need a different model.
      // For this auditor, everything returned is a detected issue.
      return allIssues;
    }

    return allIssues;
  }

  /// Audits the parity between PrimeCareForm enum and PrimeCareFormProvider switch-cases.
  Future<List<AuditIssue>> auditFormProviderParity() async {
    final List<AuditIssue> issues = [];

    final enumPath = p.join(
      projectRoot,
      'packages/flutter_core/lib/models/platform_types.dart',
    );
    final providerPath = p.join(
      projectRoot,
      'packages/flutter_core/lib/src/registry/dynamic_adapter_resolver.dart',
    );

    if (!File(enumPath).existsSync() || !File(providerPath).existsSync()) {
      return [
        AuditIssue(
          subsystem: 'primecare_ui',
          registry: 'FormProvider',
          issue: 'Registry files missing',
          suggestion:
              'Ensure the primecare_ui package is correctly structured.',
        ),
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
      final providerVisitor = _SwitchCaseVisitor(
        (name) => providerCases.add(name),
      );
      providerResult.unit.accept(providerVisitor);

      // provider path for reference
      // const relativeProviderPath = 'packages/factory_system/primecare_ui/lib/src/shared/src/registry/primecare_form_provider.dart';

      // Check for missing mappings
      for (final value in enumValues) {
        if (!providerCases.contains(value)) {
          issues.add(
            AuditIssue(
              subsystem: 'primecare_ui',
              registry: 'PrimeCareFormProvider',
              issue: 'Missing binding for Form: $value',
              suggestion: 'Run ASTPatchEngine to inject missing switch-case.',
              autoRemediable: true,
              metadata: {
                'type': 'missing_form_provider',
                'form': value,
                'targetPath':
                    'packages/flutter_core/lib/src/registry/dynamic_adapter_resolver.dart',
              },
            ),
          );
        }
      }
    } catch (e) {
      issues.add(
        AuditIssue(
          subsystem: 'primecare_governance',
          registry: 'Auditor',
          issue: 'Audit process failed: $e',
          suggestion: 'Check file permissions and AST parser compatibility.',
        ),
      );
    }

    return issues;
  }

  /// Audits the entire project for Max OOP / MVC violations.
  /// Enforces "Dumb UI" and "Pure Logic" principles.
  Future<List<AuditIssue>> auditMaxOOPCompliance() async {
    final List<AuditIssue> issues = [];
    final featuresDir = Directory(
      p.join(projectRoot, 'apps/primecare_governance/lib/features'),
    );

    if (!featuresDir.existsSync()) return issues;

    final featureSubDirs = featuresDir.listSync().whereType<Directory>();

    for (final dir in featureSubDirs) {
      final controllersDir = Directory(p.join(dir.path, 'controllers'));
      final modelsDir = Directory(p.join(dir.path, 'models'));

      // Check Controllers and Models for Flutter UI imports
      for (final logicDir in [controllersDir, modelsDir]) {
        if (logicDir.existsSync()) {
          for (final file
              in logicDir.listSync(recursive: true).whereType<File>()) {
            if (file.path.endsWith('.dart')) {
              final content = file.readAsStringSync();
              if (content.contains('package:flutter/material.dart') ||
                  content.contains('package:flutter/cupertino.dart')) {
                issues.add(
                  AuditIssue(
                    subsystem: 'governance',
                    registry: 'MaxOOPCompliance',
                    issue:
                        'Architectural Leakage: Logic layer imports UI library in ${p.basename(file.path)}',
                    suggestion:
                        'Remove UI imports from Model/Controller layers to maintain Pure Logic purity.',
                    autoRemediable: false,
                    metadata: {
                      'file': file.path,
                      'type': 'architectural_leakage',
                    },
                  ),
                );
              }
            }
          }
        }
      }
    }

    return issues;
  }

  /// Audits the network layer for mandatory security headers (CSRF, Device ID).
  Future<List<AuditIssue>> auditNetworkSecurity() async {
    final List<AuditIssue> issues = [];
    final relativeClientPath =
        'packages/flutter_core/lib/src/network/api_client.dart';
    final clientPath = p.join(projectRoot, relativeClientPath);

    if (!File(clientPath).existsSync()) {
      return issues;
    }

    final content = File(clientPath).readAsStringSync();

    if (!content.contains("'X-Requested-With': 'XMLHttpRequest'")) {
      issues.add(
        AuditIssue(
          subsystem: 'flutter_core',
          registry: 'ApiClient',
          issue: 'Missing Mandatory CSRF Header: X-Requested-With',
          suggestion:
              'Inject X-Requested-With: XMLHttpRequest into Dio BaseOptions.',
          autoRemediable: true,
          metadata: {
            'type': 'missing_security_header',
            'header': 'X-Requested-With',
            'value': 'XMLHttpRequest',
            'targetPath': relativeClientPath,
          },
        ),
      );
    }

    if (!content.contains("'X-Device-ID'")) {
      issues.add(
        AuditIssue(
          subsystem: 'flutter_core',
          registry: 'ApiClient',
          issue: 'Missing Device Governance Header: X-Device-ID',
          suggestion: 'Ensure X-Device-ID is present for audit tracking.',
          autoRemediable: true,
          metadata: {
            'type': 'missing_security_header',
            'header': 'X-Device-ID',
            'value': 'DeviceManager.instance.deviceId',
            'isRaw': true,
            'targetPath': relativeClientPath,
          },
        ),
      );
    }

    return issues;
  }

  /// Audits for Bank-Grade Security Compliance across the platform.
  Future<List<AuditIssue>> auditBankGradeSecurityCompliance() async {
    final List<AuditIssue> issues = [];

    // 1. Check for SecurityInterceptor in all network clients
    final clientPath = p.join(
      projectRoot,
      'packages/flutter_core/lib/src/network/api_client.dart',
    );
    if (File(clientPath).existsSync()) {
      final content = File(clientPath).readAsStringSync();
      if (!content.contains('SecurityInterceptor()')) {
        issues.add(
          AuditIssue(
            subsystem: 'flutter_core',
            registry: 'NetworkSecurity',
            issue: 'SecurityInterceptor not active in ApiClient',
            suggestion:
                'Register SecurityInterceptor() in Dio interceptors to enforce bank-grade signing and integrity checks.',
            autoRemediable: true,
            metadata: {
              'type': 'missing_security_interceptor',
              'targetPath':
                  'packages/flutter_core/lib/src/network/api_client.dart',
              'interceptor': 'SecurityInterceptor()',
            },
          ),
        );
      }
    }

    // 2. Check for AppIntegrity initialization in main.dart (Global Guard)
    final mainPath = p.join(
      projectRoot,
      'apps/primecare_governance/lib/main.dart',
    );
    if (File(mainPath).existsSync()) {
      final content = File(mainPath).readAsStringSync();
      if (!content.contains('AppIntegrityService.instance.checkIntegrity()')) {
        issues.add(
          AuditIssue(
            subsystem: 'primecare_governance',
            registry: 'BootstrapSecurity',
            issue: 'App integrity check missing from startup',
            suggestion:
                'Call AppIntegrityService.instance.checkIntegrity() during app bootstrap to prevent compromised device access.',
            autoRemediable: true,
            metadata: {
              'type': 'missing_bootstrap_security',
              'targetPath': 'apps/primecare_governance/lib/main.dart',
              'call': 'await AppIntegrityService.instance.checkIntegrity();',
            },
          ),
        );
      }
    }

    // 4. Check for DeviceTrustManager usage (Trusted Device Pattern)
    final bootstrapPath = p.join(
      projectRoot,
      'packages/flutter_core/lib/src/security/device_trust_manager.dart',
    );
    if (!File(bootstrapPath).existsSync()) {
      issues.add(
        AuditIssue(
          subsystem: 'flutter_core',
          registry: 'TrustedDevice',
          issue: 'DeviceTrustManager missing from core security layer',
          suggestion: 'Implement DeviceTrustManager to support device-wise access control.',
          autoRemediable: false,
        ),
      );
    }

    return issues;
  }

  /// Audits for Translation Parity across all registered screens.
  Future<List<AuditIssue>> auditTranslationParity(
    Map<String, ScreenMetadata> allScreens,
  ) async {
    final List<AuditIssue> issues = [];
    final List<String> platformSupportedLangs = ['en', 'fr', 'es', 'ar'];

    for (final entry in allScreens.entries) {
      final screen = entry.value;
      final missingLangs =
          platformSupportedLangs
              .where((lang) => !screen.translatedLanguages.contains(lang))
              .toList();

      if (missingLangs.isNotEmpty) {
        issues.add(
          AuditIssue(
            subsystem: 'primecare_governance',
            registry: 'Localization',
            issue:
                'Screen "${screen.title}" is missing translations for: ${missingLangs.join(', ')}',
            suggestion:
                'Update ScreenMetadata with missing language codes and ensure strings are translated in assets/translations.',
            autoRemediable: false,
            metadata: {
              'type': 'missing_translations',
              'screenId': screen.id,
              'missing': missingLangs,
            },
          ),
        );
      }

      // Check hasAllTranslations flag
      final bool hasAll = missingLangs.isEmpty;
      if (screen.hasAllTranslations != hasAll) {
        issues.add(
          AuditIssue(
            subsystem: 'primecare_governance',
            registry: 'Localization',
            issue: 'L10n Audit Drift: hasAllTranslations is ${screen.hasAllTranslations} but actual coverage is $hasAll',
            suggestion: 'Update hasAllTranslations flag in CoreGovernanceRegistry.',
            autoRemediable: true,
            metadata: {
              'type': 'l10n_flag_drift',
              'screenId': screen.id,
              'hasAll': hasAll,
            },
          ),
        );
      }
    }

    return issues;
  }

  /// Audits overall Article Compliance for all registered screens.
  Future<List<AuditIssue>> auditArticleCompliance(
    Map<String, ScreenMetadata> allScreens,
  ) async {
    final List<AuditIssue> issues = [];

    for (final entry in allScreens.entries) {
      final screen = entry.value;
      
      // Compliance check based on Article standards
      final bool actuallyCompliant = screen.isReadyForProduction && 
                                    screen.isFullyTranslated && 
                                    screen.hasAllTranslations &&
                                    screen.isDataBindingVerified &&
                                    screen.isNavigationVerified &&
                                    screen.isSecurityVerified &&
                                    screen.isTelemetryVerified &&
                                    (screen.isAccessibilityVerified || screen.accessibilityScore >= 90);

      if (screen.isAuditCompliant != actuallyCompliant) {
        issues.add(
          AuditIssue(
            subsystem: 'primecare_governance',
            registry: 'Compliance',
            issue: 'Compliance Drift for "${screen.title}": isAuditCompliant is ${screen.isAuditCompliant} but article pass rate requires $actuallyCompliant',
            suggestion: 'Update isAuditCompliant status in CoreGovernanceRegistry to reflect article compliance.',
            autoRemediable: true,
            metadata: {
              'type': 'compliance_drift',
              'screenId': screen.id,
              'compliant': actuallyCompliant,
            },
          ),
        );
      }
    }

    return issues;
  }

  /// Performs deep AST analysis on screen implementations to verify feature presence.
  Future<List<AuditIssue>> auditFeatureVerification(
    Map<String, ScreenMetadata> allScreens,
  ) async {
    final List<AuditIssue> issues = [];

    for (final entry in allScreens.entries) {
      final screen = entry.value;
      if (screen.sourcePath.isEmpty) continue;

      final sourceFile = File(p.join(projectRoot, screen.sourcePath));
      if (!sourceFile.existsSync()) continue;

      final content = sourceFile.readAsStringSync();
      
      // 1. Data Binding Verification
      final bool hasDataBinding = content.contains('DataLogisticsHub') || content.contains('UIAdapter');
      if (hasDataBinding && !screen.isDataBindingVerified) {
        issues.add(_createFeatureDriftIssue(screen, 'isDataBindingVerified', true));
      }

      // 2. Security Verification
      final bool hasSecurity = content.contains('SecurityInterceptor') || content.contains('RoleGuard') || content.contains('SecurityOrchestrator');
      if (hasSecurity && !screen.isSecurityVerified) {
        issues.add(_createFeatureDriftIssue(screen, 'isSecurityVerified', true));
      }

      // 3. Telemetry Verification
      final bool hasTelemetry = content.contains('AuraTelemetry.trackScreenView') || content.contains('trackScreenView');
      if (hasTelemetry && !screen.isTelemetryVerified) {
        issues.add(_createFeatureDriftIssue(screen, 'isTelemetryVerified', true));
      }

      // 4. Navigation Verification
      final bool hasNavigation = content.contains('RouteRegistry') || content.contains('deepLink');
      if (hasNavigation && !screen.isNavigationVerified) {
        issues.add(_createFeatureDriftIssue(screen, 'isNavigationVerified', true));
      }
    }

    return issues;
  }

  AuditIssue _createFeatureDriftIssue(ScreenMetadata screen, String field, bool value) {
    return AuditIssue(
      subsystem: 'primecare_governance',
      registry: 'FeatureVerification',
      issue: 'Verification Drift for "${screen.title}": $field is false but implementation is present.',
      suggestion: 'Update $field to $value in CoreGovernanceRegistry.',
      autoRemediable: true,
      metadata: {
        'type': 'feature_flag_drift',
        'screenId': screen.id,
        'field': field,
        'value': value,
      },
    );
  }

  /// Audits if all governance-defined screens exist in the ScreenRegistry.
  Future<List<AuditIssue>> auditScreenRegistryParity() async {
    final List<AuditIssue> issues = [];

    // Adaptive path resolution
    String root = projectRoot;
    if (File(p.join(root, 'pubspec.yaml')).existsSync() &&
        !Directory(p.join(root, 'packages')).existsSync()) {
      root = p.normalize(p.join(root, '../..'));
    }

    final blueprintPath = p.normalize(
      p.join(root, '.agents/governance/blueprints.yaml'),
    );
    final screenRegistryPath = p.normalize(
      p.join(
        root,
        'apps/primecare_governance/lib/core/governance/registries/core_governance_registry.dart',
      ),
    );

    if (!File(blueprintPath).existsSync() ||
        !File(screenRegistryPath).existsSync()) {
      return [
        AuditIssue(
          subsystem: 'primecare_governance',
          registry: 'ScreenRegistry',
          issue: 'Registry or Blueprint files missing',
          suggestion:
              'Ensure both blueprints.yaml and CoreGovernanceRegistry exist.',
        ),
      ];
    }

    try {
      final blueprintContent = File(blueprintPath).readAsStringSync();
      final registryContent = File(screenRegistryPath).readAsStringSync();

      final yaml = loadYaml(blueprintContent);
      final registryResult = parseString(content: registryContent);

      // 1. Load Blueprint Definitions
      final blueprintDefinitions = <String, List<String>>{};
      final blueprintsList = yaml['blueprints'] as YamlList;
      for (final b in blueprintsList) {
        final id = b['id'] as String;
        final comps = (b['required_components'] as YamlList)
            .map((c) => c['id'] as String)
            .toList();
        blueprintDefinitions[id] = comps;
      }

      // 2. Load Screen-to-Blueprint Mappings
      final mappings = <String, String>{};
      final registries = yaml['registries'] as YamlList;
      for (final r in registries) {
        if (r['id'] == 'registry.auditor') {
          final mapped = r['mapped_blueprints'] as YamlList;
          for (final entry in mapped) {
            mappings[entry['screen_id'] as String] =
                entry['blueprint_id'] as String;
          }
        }
      }

      // 3. Load Registered Screens from CoreGovernanceRegistry
      final registeredScreens =
          <String, ({String route, List<String> components, String? status})>{};
      final registryVisitor = _ScreenRegistryMetadataVisitor((
        id,
        route,
        components,
        status,
      ) {
        registeredScreens[id] = (
          route: route,
          components: components,
          status: status,
        );
      });
      registryResult.unit.accept(registryVisitor);

      // 4. Perform Parity Audit
      for (final mapping in mappings.entries) {
        final screenId = mapping.key;
        final blueprintId = mapping.value;

        // Normalize Screen ID for matching (e.g., 'clinical.psw.dashboard' -> 'SCREEN_PSW_DASHBOARD')
        final parts = screenId.split('.');
        final normalizedId = 'SCREEN_${parts.skip(1).join('_').toUpperCase()}';

        final screenData =
            registeredScreens[normalizedId] ??
            registeredScreens[screenId.toUpperCase().replaceAll('.', '_')];

        if (screenData == null) {
          issues.add(
            AuditIssue(
              subsystem: 'primecare_governance',
              registry: 'CoreGovernanceRegistry',
              issue: 'Mapped screen not found: $screenId (tried $normalizedId)',
              suggestion: 'Register $normalizedId in CoreGovernanceRegistry.',
              autoRemediable: true,
              metadata: {
                'type': 'missing_registration',
                'screenId': normalizedId,
                'mapping': screenId,
              },
            ),
          );
          continue;
        }

        final requiredComps = blueprintDefinitions[blueprintId];
        if (requiredComps == null) {
          issues.add(
            AuditIssue(
              subsystem: 'primecare_governance',
              registry: 'Blueprints',
              issue: 'Reference to unknown blueprint: $blueprintId',
              suggestion: 'Define $blueprintId in blueprints.yaml.',
            ),
          );
          continue;
        }

        final implementedComps = screenData.components;
        final missingComps = requiredComps
            .where((c) => !implementedComps.contains(c))
            .toList();

        if (missingComps.isNotEmpty) {
          issues.add(
            AuditIssue(
              subsystem: 'primecare_governance',
              registry: 'CoreGovernanceRegistry',
              issue: 'Structural Drift in $normalizedId: Missing $missingComps',
              suggestion:
                  'Implement missing components to match blueprint $blueprintId.',
              autoRemediable: true,
              metadata: {
                'type': 'structural_drift',
                'screenId': normalizedId,
                'blueprintId': blueprintId,
                'missing': missingComps,
              },
            ),
          );
        }
      }
    } catch (e) {
      issues.add(
        AuditIssue(
          subsystem: 'primecare_governance',
          registry: 'Auditor',
          issue: 'Audit process failed: $e',
          suggestion: 'Check YAML syntax and registry file structure.',
        ),
      );
    }

    return issues;
  }

  /// Audits parity between ScreenMetadata and ApiGovernanceRegistry.
  /// Enforces 4K design standards and orphan detection.
  Future<List<AuditIssue>> auditApiParity() async {
    final List<AuditIssue> issues = [];
    final allScreens = CoreGovernanceRegistry.screens;
    final allApis = ApiGovernanceRegistry.endpoints;

    // 1. Check for Orphaned API Requirements in Screens
    for (final screen in allScreens.values) {
      for (final apiId in screen.requiredApis) {
        if (!allApis.containsKey(apiId)) {
          issues.add(
            AuditIssue(
              subsystem: 'primecare_governance',
              registry: 'ApiParity',
              issue: 'Orphaned API Requirement: Screen "${screen.title}" requires "$apiId" which is not registered.',
              suggestion: 'Register "$apiId" in ApiGovernanceRegistry.',
              autoRemediable: false,
              metadata: {
                'type': 'orphaned_api_requirement',
                'screenId': screen.id,
                'apiId': apiId,
              },
            ),
          );
        }
      }
    }

    // 2. Check for 4K Standard Compliance across all API Endpoints
    for (final api in allApis.values) {
      if (api.designSize == null || api.designSize!.width != 3840) {
        issues.add(
          AuditIssue(
            subsystem: 'governance_api',
            registry: 'ApiParity',
            issue: '4K Standard Violation: API "${api.id}" is missing 3840x2160 design size attribute.',
            suggestion: 'Assign designSize: const Size(3840, 2160) to the API registry entry.',
            autoRemediable: true,
            metadata: {
              'type': '4k_standard_violation',
              'apiId': api.id,
              'requiredWidth': 3840,
              'requiredHeight': 2160,
            },
          ),
        );
      }
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

/*
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
                    if (compArg is NamedExpression &&
                        compArg.name.label.name == 'label') {
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
*/

class _ScreenRegistryMetadataVisitor extends RecursiveAstVisitor<void> {
  final void Function(
    String id,
    String route,
    List<String> components,
    String? status,
  )
  onMetadata;
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
