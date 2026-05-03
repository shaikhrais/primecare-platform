import 'package:flutter_core/flutter_core.dart';
import 'package:collection/collection.dart';
import 'package:primecare_ui/src/engine/screen_engine.dart';
import 'package:primecare_ui/src/registries.dart';
import 'package:primecare_ui/src/shared/src/models/core/dashboard_models.dart';
import 'package:primecare_ui/src/shared/src/models/core/ui_blueprint.dart';
import 'package:primecare_ui/src/shared/src/core/primecare_components.dart';
import 'package:primecare_ui/src/i18n/locale_keys.g.dart';
import 'package:primecare_ui/src/governance_bootstrapper.dart';
import 'package:primecare_ui/src/shared/src/models/core/render_config.dart';
import 'package:primecare_ui/src/shared/src/generic/dynamic_adapter_provider.dart';
import 'package:primecare_ui/src/shared/src/registry/primecare_form_enum.dart';
import 'package:primecare_ui/src/shared/src/registry/governance_blueprint_hud.dart';

class KpiConfig {
  final String title;
  final String value;
  final String deltaSuffix;
  final IconData icon;
  final Color iconColor;

  const KpiConfig({
    required this.title,
    required this.value,
    required this.deltaSuffix,
    required this.icon,
    required this.iconColor,
  });

  factory KpiConfig.fromJson(Map<String, dynamic> json) {
    return KpiConfig(
      title: json['title'] as String? ?? 'dashboards.common.labels.stat',
      value: json['value'] as String? ?? '0',
      deltaSuffix: json['deltaSuffix'] as String? ?? '',
      icon: _getIconData(json['icon'] as String?),
      iconColor: _getColor(json['iconColor'] as String?),
    );
  }

  static IconData _getIconData(String? name) {
    switch (name) {
      case 'users':
        return LucideIcons.users;
      case 'stethoscope':
        return LucideIcons.stethoscope;
      case 'dollarSign':
        return LucideIcons.dollarSign;
      case 'shieldAlert':
        return LucideIcons.shieldAlert;
      case 'briefcase':
        return LucideIcons.briefcase;
      case 'barChart2':
        return LucideIcons.barChart2;
      case 'heart':
        return LucideIcons.heartPulse;
      case 'clipboardList':
        return LucideIcons.clipboardList;
      case 'userCheck':
        return LucideIcons.userCheck;
      case 'clock':
        return LucideIcons.clock;
      case 'graduationCap':
        return LucideIcons.graduationCap;
      case 'zap':
        return LucideIcons.zap;
      default:
        return LucideIcons.barChart;
    }
  }

  static Color _getColor(String? name) {
    switch (name) {
      case 'blue':
        return Colors.blueAccent;
      case 'teal':
        return Colors.tealAccent;
      case 'green':
        return Colors.greenAccent;
      case 'orange':
        return Colors.orangeAccent;
      case 'purple':
        return Colors.purpleAccent;
      case 'red':
        return Colors.redAccent;
      case 'pink':
        return Colors.pinkAccent;
      case 'amber':
        return Colors.amberAccent;
      default:
        return Colors.blueGrey;
    }
  }
}

class DashboardConfig {
  final String title;
  final String subtitle;
  final List<KpiConfig> kpis;
  final RenderConfig rendering;
  final Widget? customView;

  const DashboardConfig({
    required this.title,
    required this.subtitle,
    required this.kpis,
    this.rendering = const RenderConfig(),
    this.customView,
  });

  factory DashboardConfig.fromJson(Map<String, dynamic> json) {
    return DashboardConfig(
      title: json['title'] as String? ?? 'dashboards.common.labels.dashboards',
      subtitle:
          json['subtitle'] as String? ?? 'dashboards.common.labels.overview_metrics',
      kpis:
          (json['kpis'] as List<dynamic>?)
              ?.map((kpi) => KpiConfig.fromJson(kpi as Map<String, dynamic>))
              .toList() ??
          [],
      rendering: json['rendering'] != null
          ? RenderConfig.fromJson(json['rendering'] as Map<String, dynamic>)
          : const RenderConfig(),
    );
  }
}

/// Central DashboardRegistry mapping application routes to dynamic dashboard JSON configurations.
class ScreenRegistry {
  static final Map<String, PrimeCareScreen> _objectRegistry = {};
  static bool _isBootstrapped = false;

  // We represent the registry as JSON structures so it can easily be backed by an API/Edge Worker later.
  static final Map<String, Map<String, dynamic>> registryJson = {};

  /// Returns all registered screens.
  static List<PrimeCareScreen> getAllScreens() => _objectRegistry.values.toList();

  /// Map of registered screens by route.
  static Map<String, PrimeCareScreen> get screens => Map.unmodifiable(_objectRegistry);

  /// Registers a high-fidelity screen object.
  static void registerScreen(PrimeCareScreen screen) {
    _objectRegistry[screen.route] = screen;
    // Auto-register with governance as well
    GovernanceRegistry.register(screen);
  }

  /// Bootstraps the high-fidelity registry with pilot modules.
  /// This will eventually replace the manual route registry in the UI layer.
  static void bootstrap() {
    if (_isBootstrapped) return;
    _isBootstrapped = true;

    // Initialize the global renderer bridge
    AppScreenIntent.globalRenderer = (context, intent) {
      if (intent is PrimeCareScreen) {
        return UniversalScreenEngine(screen: intent);
      }
      return Center(
        child: Text(
          LocaleKeys
              .dashboards_common_labels_unsupported_intent_type____intent_runtimetype
              .tr(),
        ),
      );
    };

    final registries = [
      CorporateRegistry(),
      FranchiseRegistry(),

      ClinicalRegistry(),
      BusinessDevelopmentRegistry(),
      ClientPortalRegistry(),
      AdminInfrastructureRegistry(),
      MarketingRegistry(),
      WorkflowsFormsRegistry(),
      OperationalRegistry(),
      SupportRegistry(),
      RegionalFinanceRegistry(),
    ];

    for (final registry in registries) {
      registry.bootstrap();
      registryJson.addAll(registry.registryJson);
    }

    // 2. Specialized Multi-Blueprint Screens (Dynamic Dashboards)
    _registerDynamicDashboards();

    // 3. Register the generic DYNAMIC_ROLE_DASHBOARD template
    registerScreen(
      PrimeCareScreen(
        name: 'DYNAMIC_ROLE_DASHBOARD',
        title: LocaleKeys.dashboards_common_labels_dynamic_dashboard,
        route: 'DYNAMIC_ROLE_DASHBOARD',
        requiredRole: PlatformRole.dynamicScreen,
        form: PrimeCareForm.dynamicRoleDashboard,
        provider: genericDashboardAdapterProvider(PrimeCareForm.dynamicRoleDashboard),
        componentLabels: ['Aura HUD', 'Dynamic Content'],
      ),
    );

    // 4. Ensure Governance System is primed (Called at the end to allow reconciliation loop to see all screens)
    GovernanceBootstrapper.bootstrap();
  }

  static void _registerDynamicDashboards() {
    registryJson.forEach((role, config) {
      final String route = (config['route'] ?? config['path']) as String;

      if (_objectRegistry.containsKey(route)) {
        return;
      }

      final List<Map<String, dynamic>> kpis =
          (config['kpis'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      final String? hfViewId = config['highFidelityViewId'] as String?;

      final form = PrimeCareForm.fromString(role) ?? PrimeCareForm.genericDashboard;
      registerScreen(
        PrimeCareScreen(
          name: role,
          title: config['title'] as String,
          subtitle: config['subtitle'] as String? ?? '',
          form: form,
          route: route,
          requiredRole: PlatformRole.dynamicScreen, // Generic for dynamic
          provider: genericDashboardAdapterProvider(form),
          blueprints: hfViewId != null
              ? <UIComponentBlueprint>[
                  const AuraDashboardHudBlueprint(),
                  HighFidelityScreenBlueprint(viewId: hfViewId),
                ]
              : <UIComponentBlueprint>[
                  const AuraDashboardHudBlueprint(),
                  StatGridBlueprint(
                    dataPayload: kpis
                        .map(
                          (k) => KpiMetric(
                            title: k['title'] as String? ?? 'dashboards.common.labels.stat',
                            value: k['value'] as String? ?? '0',
                            subtitle: k['deltaSuffix'] as String? ?? '',
                            status: 'neutral',
                          ),
                        )
                        .toList(),
                  ),
                ],
          componentLabels:
              (config['componentLabels'] as List?)?.cast<String>() ??
              (hfViewId != null
                  ? ['Aura HUD', 'High-Fidelity View ($hfViewId)']
                  : ['Aura HUD', 'KPI Stat Grid']),
          structuralPlan: config['structuralPlan'] as String?,
        ),
      );
    });
  }

  static List<PrimeCareScreen> getAllRegisteredScreens() {
    return _objectRegistry.values.toList();
  }

  /// Retrieves a registered screen by its name.
  static PrimeCareScreen? getScreenByName(String name) {
    if (!_isBootstrapped) {
      bootstrap();
    }
    return _objectRegistry.values.firstWhereOrNull((s) => s.name == name);
  }

  /// Resolves a screen by its associated [PrimeCareForm] enum member.
  static PrimeCareScreen? getScreenByForm(PrimeCareForm form) {
    if (!_isBootstrapped) {
      bootstrap();
    }
    return _objectRegistry.values.firstWhereOrNull((s) => s.form == form);
  }

  /// Retrieves a registered screen by its route.
  static PrimeCareScreen? getScreen(String route) {
    if (!_isBootstrapped) {
      bootstrap();
    }

    // 1. Exact route match
    if (_objectRegistry.containsKey(route)) {
      return _objectRegistry[route];
    }

    // Fallback to GovernanceRegistry for specialized intents
    AppScreenIntent? intent = GovernanceRegistry.getIntentByRoute(route);
    intent ??= GovernanceRegistry.getIntentByRole(route);

    if (intent is PrimeCareScreen) {
      return intent;
    }

    // 2. Name match (if route is 'receptionist' instead of '/receptionist')
    final byName = _objectRegistry.values
        .where((s) => s.name == route || s.route.endsWith('/$route'))
        .firstOrNull;
    if (byName != null) return byName;

    // 3. Role match
    final byRole = _objectRegistry.values
        .where((s) => s.requiredRole?.toString().split('.').last == route)
        .firstOrNull;
    if (byRole != null) return byRole;

    return null;
  }

  static Widget buildScreen(
    BuildContext context,
    String key, {
    WidgetRef? ref,
  }) {
    final screen = getScreen(key);

    // 1. Telemetry: Capture Mount Event
    if (ref != null) {
      ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            eventType: 'screen_mount',
            route: key,
            metadata: {
              'is_registered': screen != null,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    }

    if (screen != null) {
      // 2. Governance: Programmatic Validation Hook
      if (ref != null) {
        final blueprint = BlueprintRegistry.getBlueprint(screen.route);
        if (blueprint != null) {
          final compliance = blueprint.audit(screen.componentLabels);
          ref
              .read(auraBehavioralTelemetryProvider)
              .logValidationResult(
                route: screen.route,
                isCompliant: compliance.isCompliant,
                details: compliance.toString(),
              );
        }
      }

      // 3. Integration: Wrap with Architectural HUD for real-time verification
      return GovernanceBlueprintHUD(
        intent: screen,
        child: screen.build(context),
      );
    }

    // Fallback to recovery UI
    return const DashboardLoadingWidget();
  }

  static DashboardConfig getDashboardForRoute(
    String route,
    BuildContext context,
  ) {
    final screen = getScreen(route);

    if (screen != null) {
      return DashboardConfig(
        title: screen.title,
        subtitle: screen.subtitle,
        kpis: [],
        customView: screen.build(context),
      );
    }

    // 2. Secondary: Governance Dashboard Lookup
    final intent = GovernanceRegistry.getIntentByRoute(route);

    if (intent != null) {
      return DashboardConfig(
        title: intent.title,
        subtitle: intent.subtitle,
        kpis: [], // Handled by specialized view
        customView: intent.build(context), // Context handled by framework
      );
    }

    // 2. Secondary: Role-based search (for deep linking or role-based recovery)
    // Extract role from route if it follows the pattern /offices/.../roles/<role>/dashboard
    final roleMatch = RegExp(r'roles/(\w+)/dashboard').firstMatch(route);
    if (roleMatch != null) {
      final role = roleMatch.group(1)!;
      final roleIntent = GovernanceRegistry.getIntentByRole(role);
      if (roleIntent != null) {
        return DashboardConfig(
          title: roleIntent.title,
          subtitle: roleIntent.subtitle,
          kpis: [],
          customView: roleIntent.build(context),
        );
      }
    }

    // 3. Fallback: Systematic Route Recovery
    return DashboardConfig(
      title: LocaleKeys.dashboards_common_labels_institutional_route_recovery
          .tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_the_system_is_verifying_your_security_context_for___route
          .tr(),
      kpis: [],
      customView: const DashboardLoadingWidget(),
    );
  }

  /// Performs a comprehensive audit of all registered screens.
  /// Used by the Pre-Deployment Integrity Guardian.
  static List<RegistryAuditReport> auditRegistry() {
    if (!_isBootstrapped) bootstrap();

    final List<RegistryAuditReport> reports = [];

    // Audit static registry
    _objectRegistry.forEach((route, screen) {
      final issues = <String>[];
      final blueprint = BlueprintRegistry.getBlueprint(route);
      final compliance = blueprint?.audit(screen.componentLabels);
      if (compliance != null && !compliance.isCompliant) {
        issues.add(
          'Blueprint Mismatch: ${compliance.criticalMismatches.join(", ")}',
        );
      }

      reports.add(
        RegistryAuditReport(
          route: route,
          isHealthy: issues.isEmpty,
          message: issues.join(', '),
          componentLabels: screen.componentLabels,
          compliance: compliance,
        ),
      );
    });

    // Audit Governance intents
    final intents = GovernanceRegistry.getAllIntents();
    for (final intent in intents) {
      final issues = <String>[];
      if (intent.title.isEmpty) issues.add('Missing title');
      if (intent.route.isEmpty) issues.add('Missing route');

      final blueprint = BlueprintRegistry.getBlueprint(intent.route);
      final compliance = blueprint?.audit(intent.componentLabels);
      if (compliance != null && !compliance.isCompliant) {
        issues.add(
          'Blueprint Mismatch: ${compliance.criticalMismatches.join(", ")}',
        );
      }

      reports.add(
        RegistryAuditReport(
          route: intent.route,
          isHealthy: issues.isEmpty,
          message: issues.join(', '),
          componentLabels: intent.componentLabels,
          compliance: compliance,
        ),
      );
    }

    return reports;
  }
}

class RegistryAuditReport {
  final String route;
  final bool isHealthy;
  final String message;
  final List<String> componentLabels;
  final BlueprintCompliance? compliance;

  RegistryAuditReport({
    required this.route,
    required this.isHealthy,
    this.message = '',
    this.componentLabels = const [],
    this.compliance,
  });
}
