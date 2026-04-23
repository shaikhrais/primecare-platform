// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';
import '../registry/intents/01_I_app_screen_intent.dart';
import '../registry/01_I_platform_role.dart';

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

  final String? _routeOverride;
  
  /// The UI blueprint defining which components to render.
  final List<UIComponentBlueprint> blueprints;

  /// Optional layout configuration (e.g. 'dashboard', 'form', 'split').
  final String layoutType;

  @override
  final List<String> componentLabels;

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
    String? route,
  }) : name = name ?? (route ?? '').split('/').last, _routeOverride = route;

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
