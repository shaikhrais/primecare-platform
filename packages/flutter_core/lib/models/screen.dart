// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

/// The unified, high-fidelity definition of a PrimeCare screen.
/// This object is the single source of truth for routing, hydration, and rendering.
/// It merges the concepts of Intent, Config, and Definition.
class PrimeCareScreen extends AppScreenIntent {
  @override
  final String name;

  @override
  final String title;

  @override
  final String subtitle;

  @override
  final PlatformRole? requiredRole;

  /// The primary data provider for this screen (usually an Adapter Provider).
  @override
  final dynamic provider;

  @override
  final ResiliencePolicy resiliencePolicy;

  @override
  final PlatformSubsystem? primarySubsystem;

  final String? _routeOverride;

  /// The UI blueprint defining which components to render.
  final List<UIComponentBlueprint> blueprints;

  /// Optional layout configuration (e.g. 'dashboard', 'form', 'split').
  final String layoutType;

  @override
  final List<String> componentLabels;

  @override
  final String structuralPlan;

  PrimeCareScreen({
    String? name,
    required this.title,
    this.subtitle = '',
    this.requiredRole,
    this.provider,
    this.blueprints = const [],
    this.layoutType = 'dashboard',
    this.componentLabels = const [],
    this.resiliencePolicy = const ResiliencePolicy(),
    this.primarySubsystem = PlatformSubsystem.metrics,
    String? structuralPlan,
    String? route,
  }) : name = name ?? (route ?? '').split('/').last,
       _routeOverride = route,
       structuralPlan =
           structuralPlan ??
           _generateSmartStructuralPlan(
             name ?? (route ?? '').split('/').last,
             route ?? '',
             componentLabels,
           );

  static String _generateSmartStructuralPlan(
    String name,
    String route,
    List<String> labels,
  ) {
    final category = route.contains('/report')
        ? 'Analytical Report'
        : (route.contains('/form')
              ? 'Data Entry Interface'
              : 'Operational Dashboard');
    final context = name
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(' ')
        .map(
          (s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : '',
        )
        .join(' ');

    final componentsStr = labels.isEmpty
        ? 'Standard UI Components'
        : labels.join(', ');

    return '$category for $context: This architectural layout is strictly governed by the PrimeCare v4 Structural Integrity Framework. It prioritizes $category resilience and data hydration transparency. Active components include: $componentsStr.';
  }

  @override
  String get route => _routeOverride ?? '/$name';

  /// Factory for creating a standard Dashboard.
  factory PrimeCareScreen.dashboard({
    required String name,
    required String title,
    String? subtitle,
    PlatformRole? role,
    required dynamic provider,
    List<UIComponentBlueprint> blueprints = const [],
    List<String> componentLabels = const [],
  }) {
    return PrimeCareScreen(
      name: name,
      title: title,
      subtitle: subtitle ?? 'Governed Portal for $title',
      requiredRole: role,
      provider: provider,
      blueprints: blueprints,
      componentLabels: componentLabels,
      layoutType: 'dashboard',
      primarySubsystem: PlatformSubsystem.metrics,
    );
  }

  /// Factory for creating a standard Form.
  factory PrimeCareScreen.form({
    required String name,
    required String title,
    required dynamic provider,
    List<UIComponentBlueprint> blueprints = const [],
  }) {
    return PrimeCareScreen(
      name: name,
      title: title,
      provider: provider,
      blueprints: blueprints,
      layoutType: 'form',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (AppScreenIntent.globalRenderer != null) {
      return AppScreenIntent.globalRenderer!(context, this);
    }
    return Center(
      child: Text(
        'Renderer not initialized for $title. Please check the GovernanceBootstrapper.',
      ),
    );
  }
}
