import 'package:flutter_core/00_B_flutter_core.dart';

import '../engine/02_I_screen_engine.dart';
import '../components/dashboards/01_I_dashboard_state_widgets.dart';
import '02_I_governance_bootstrapper.dart';
import '../components/01_I_governance_blueprint_hud.dart';

import 'offices/corporate_registry.dart';
import 'offices/franchise_registry.dart';

import 'offices/clinical_registry.dart';
import 'offices/business_development_registry.dart';
import 'offices/client_portal_registry.dart';
import 'offices/admin_infrastructure_registry.dart';
import 'offices/marketing_registry.dart';

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
      title: json['title'] as String? ?? 'Stat',
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
      title: json['title'] as String? ?? 'Dashboard',
      subtitle:
          json['subtitle'] as String? ?? 'Overview metrics and operations.',
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

/// Central Registry mapping application routes to dynamic dashboard JSON configurations.
class ScreenRegistry {
  static final Map<String, PrimeCareScreen> _objectRegistry = {};
  static bool _isBootstrapped = false;

  // We represent the registry as JSON structures so it can easily be backed by an API/Edge Worker later.
  static final Map<String, Map<String, dynamic>> registryJson = {};

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

    // Ensure Governance System is primed
    GovernanceBootstrapper.bootstrap();

    // Initialize the global renderer bridge
    AppScreenIntent.globalRenderer = (context, intent) {
      if (intent is PrimeCareScreen) {
        return UniversalScreenEngine(screen: intent);
      }
      return Center(
        child: Text('Unsupported Intent Type: ${intent.runtimeType}'),
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
    ];

    for (final registry in registries) {
      registry.bootstrap();
      registryJson.addAll(registry.registryJson);
    }

    // 2. Specialized Multi-Blueprint Screens (Dynamic Dashboards)
    _registerDynamicDashboards();

    _isBootstrapped = true;
  }

  static void _registerDynamicDashboards() {
    registryJson.forEach((role, config) {
      final String route = config['route'] as String;
      final List<Map<String, dynamic>> kpis =
          (config['kpis'] as List?)?.cast<Map<String, dynamic>>() ?? [];

      final String? hfViewId = config['highFidelityViewId'] as String?;

      registerScreen(
        PrimeCareScreen(
          name: role,
          title: config['title'] as String,
          subtitle: config['subtitle'] as String? ?? '',
          route: route,
          requiredRole: PlatformRole.dynamicScreen, // Generic for dynamic
          provider: genericDashboardAdapterProvider(
            PrimeCareForm.fromString(role) ?? PrimeCareForm.genericDashboard,
          ),
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
                            title: k['title'] as String? ?? 'Stat',
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

    // 2. Secondary: Governance Intent Lookup
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
      title: 'Institutional Route Recovery',
      subtitle: 'The system is verifying your security context for: $route',
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
