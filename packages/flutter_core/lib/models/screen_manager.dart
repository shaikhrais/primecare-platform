import 'package:flutter/material.dart';

import 'screen.dart' show AppShellBoundary;
import 'screen_features.dart';

/// Presentation dependencies required by a managed screen. These do not
/// represent authentication, authorization, or permission to access a route.
enum ScreenDependency { layout, theme, language, responsive }

@immutable
class ManagedScreenRegistration {
  const ManagedScreenRegistration({
    required this.id,
    this.features,
  });

  final String id;
  /// Null preserves the application defaults.
  final ScreenFeatureConfig? features;
  static const Set<ScreenDependency> dependencies = {
    ScreenDependency.layout,
    ScreenDependency.theme,
    ScreenDependency.language,
    ScreenDependency.responsive,
  };
}

/// An explicit, immutable set of screen registrations. It grants no access.
class ScreenManager {
  ScreenManager(Iterable<ManagedScreenRegistration> registrations)
      : _registrations = _index(registrations);

  final Map<String, ManagedScreenRegistration> _registrations;

  static Map<String, ManagedScreenRegistration> _index(
      Iterable<ManagedScreenRegistration> registrations) {
    final result = <String, ManagedScreenRegistration>{};
    for (final registration in registrations) {
      if (registration.id.trim().isEmpty || result.containsKey(registration.id)) {
        throw ArgumentError('Screen registration has an empty or duplicate id: ${registration.id}');
      }
      result[registration.id] = registration;
    }
    return Map.unmodifiable(result);
  }

  ManagedScreenRegistration? lookup(String id) => _registrations[id];

  /// Combines an application's existing route metadata with shared defaults.
  /// Existing registrations retain their configuration and this never grants
  /// access; routers must still authorize each request independently.
  ScreenManager withAdditionalRoutes(Iterable<String> routes) {
    final extra = routes.toSet().difference(_registrations.keys.toSet());
    return ScreenManager([
      ..._registrations.values,
      ...extra.map((route) => ManagedScreenRegistration(id: route)),
    ]);
  }
}

/// Checks registration and dependencies before invoking the screen builder.
/// Place this inside existing authentication and authorization boundaries.
class ManagedScreenBoundary extends StatelessWidget {
  const ManagedScreenBoundary({
    super.key,
    required this.manager,
    required this.screenId,
    required this.builder,
  });

  final ScreenManager manager;
  final String screenId;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final registration = manager.lookup(screenId);
    if (registration == null) {
      throw FlutterError('Screen Manager: screen "$screenId" is not registered.');
    }
    final missing = <ScreenDependency>[];
    for (final dependency in ManagedScreenRegistration.dependencies) {
      final available = switch (dependency) {
        ScreenDependency.layout => AppShellBoundary.isActive(context),
        ScreenDependency.theme => context.findAncestorWidgetOfExactType<Theme>() != null,
        ScreenDependency.language => Localizations.maybeLocaleOf(context) != null && Directionality.maybeOf(context) != null,
        ScreenDependency.responsive => MediaQuery.maybeOf(context) != null,
      };
      if (!available) missing.add(dependency);
    }
    if (missing.isNotEmpty) {
      throw FlutterError('Screen Manager: screen "$screenId" is missing required connections: ${missing.map((item) => item.name).join(', ')}.');
    }
    return ScreenFeatureScope(
      features: registration.features ?? ScreenFeatureScope.of(context),
      child: Builder(builder: builder),
    );
  }
}
