import 'package:flutter/widgets.dart';
import 'package:flutter_core/models/screen.dart' show AppShellBoundary;
import 'package:flutter_core/models/screen_manager.dart';
import '../features/auth/generated_managed_routes.g.dart';
import '../features/platform/platform_master_catalog.g.dart';
import '../features/workspace/workspace_routes_generated.dart';
import '../theme/prime_theme.dart';
import 'module_screen_registrations.dart';

/// Shared presentation registrations. Authentication and permission decisions
/// remain with the existing routers and services.
final ScreenManager primeCareScreenManager = ScreenManager([
  const ManagedScreenRegistration(id: '/login'),
  const ManagedScreenRegistration(id: '/signup'),
  const ManagedScreenRegistration(id: '/forgot-password'),
  const ManagedScreenRegistration(id: '/reset-password'),
  const ManagedScreenRegistration(id: '/mfa'),
  const ManagedScreenRegistration(id: '/language'),
  const ManagedScreenRegistration(id: '/auth/error'),
  const ManagedScreenRegistration(id: '/auth/callback'),
  const ManagedScreenRegistration(id: '/common/settings'),
  const ManagedScreenRegistration(id: '/consent'),
  const ManagedScreenRegistration(id: '/success'),
  ManagedScreenRegistration(id: platformAdministrationRoute),
  const ManagedScreenRegistration(id: '/maintenance/configuration'),
  const ManagedScreenRegistration(id: '/internal/training/guide'),
  const ManagedScreenRegistration(id: '/internal/training/detail'),
  const ManagedScreenRegistration(id: '/internal/unauthorized-fallback'),
  const ManagedScreenRegistration(id: '/internal/access-denied'),
  const ManagedScreenRegistration(id: '/internal/guest-error'),
  const ManagedScreenRegistration(id: '/admin/screenshot-inventory'),
  ...governedWorkspaceRoutes.keys.map((route) => ManagedScreenRegistration(id: route)),
], connections: {
  'PrimeTheme': (context) => context.dependOnInheritedWidgetOfExactType<PrimeTheme>() != null,
}).withAdditionalRoutes(moduleScreenRegistrations)
  .withAdditionalRoutes(generatedManagedScreenRoutes);

/// Adapter for an already-authorized standalone route or navigator page.
Widget managedPrimeCarePage(String id, WidgetBuilder builder) => AppShellBoundary(
  child: ManagedScreenBoundary(manager: primeCareScreenManager, screenId: id, builder: builder),
);
