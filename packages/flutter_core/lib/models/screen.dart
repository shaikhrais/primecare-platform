// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE Base class for governed consumer widgets. Enforces layout invariants by making it impossible...
// Layer: 01_INFRASTRUCTURE
import '../registry/platform_role.dart';
import 'package:flutter_core/flutter_core.dart';
import '../registry/intents/app_screen_intent.dart';
import 'platform_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '../registry/widgets/responsive_screen_wrapper.dart';

/// Interface for declaring screen governance requirements.
abstract class ScreenGovernance {
  /// A functional description of the screen's core purpose and workflows.
  String get screenDescription;

  /// The list of UI components required to build this screen.
  List<String> get requiredComponents;

  /// The list of core functions or operations handled by this screen.
  List<String> get requiredFunctions;
}

/// Base class for governed consumer widgets.
/// Enforces layout invariants by making it impossible to render directly to a route.
abstract class GovernedConsumerWidget extends ConsumerWidget implements ScreenGovernance {
  const GovernedConsumerWidget({super.key});

  @override
  String get screenDescription => '';

  @override
  List<String> get requiredComponents => const [];

  @override
  List<String> get requiredFunctions => const [];

  @override
  @nonVirtual
  Widget build(BuildContext context, WidgetRef ref) {
    assert(
      AppShellBoundary.isActive(context),
      'Layout Invariant Violation: All screens must be rendered within a MasterLayout shell. Direct routing without the shell is prohibited. Screen: $runtimeType',
    );
    if (!AppShellBoundary.isActive(context)) {
      throw FlutterError(
        'Layout Invariant Violation: All Governed screens must be rendered within a MasterLayout shell. '
        'Direct routing without the shell is prohibited. Screen: $runtimeType',
      );
    }
    return ResponsiveScreenWrapper(child: buildScreen(context, ref));
  }

  /// Override this instead of [build] to implement the screen UI.
  Widget buildScreen(BuildContext context, WidgetRef ref);
}

/// Base class for governed stateless widgets.
/// Enforces layout invariants by making it impossible to render directly to a route.
abstract class GovernedStatelessWidget extends StatelessWidget implements ScreenGovernance {
  const GovernedStatelessWidget({super.key});

  @override
  String get screenDescription => '';

  @override
  List<String> get requiredComponents => const [];

  @override
  List<String> get requiredFunctions => const [];

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    assert(
      AppShellBoundary.isActive(context),
      'Layout Invariant Violation: All screens must be rendered within a MasterLayout shell. Direct routing without the shell is prohibited. Screen: $runtimeType',
    );
    if (!AppShellBoundary.isActive(context)) {
      throw FlutterError(
        'Layout Invariant Violation: All Governed screens must be rendered within a MasterLayout shell. '
        'Direct routing without the shell is prohibited. Screen: $runtimeType',
      );
    }
    return ResponsiveScreenWrapper(child: buildScreen(context));
  }

  /// Override this instead of [build] to implement the screen UI.
  Widget buildScreen(BuildContext context);
}

/// Base class for governed consumer stateful widgets.
abstract class GovernedConsumerStatefulWidget extends ConsumerStatefulWidget {
  const GovernedConsumerStatefulWidget({super.key});
}

/// Base State class for governed consumer stateful widgets.
/// Enforces layout invariants by making it impossible to render directly to a route.
abstract class GovernedConsumerState<T extends GovernedConsumerStatefulWidget>
    extends ConsumerState<T> implements ScreenGovernance {
  @override
  String get screenDescription => '';

  @override
  List<String> get requiredComponents => const [];

  @override
  List<String> get requiredFunctions => const [];

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    assert(
      AppShellBoundary.isActive(context),
      'Layout Invariant Violation: All screens must be rendered within a MasterLayout shell. Direct routing without the shell is prohibited. Screen: $runtimeType',
    );
    if (!AppShellBoundary.isActive(context)) {
      throw FlutterError(
        'Layout Invariant Violation: All Governed screens must be rendered within a MasterLayout shell. '
        'Direct routing without the shell is prohibited. Screen: $runtimeType',
      );
    }
    return ResponsiveScreenWrapper(child: buildScreen(context));
  }

  /// Override this instead of [build] to implement the screen UI.
  Widget buildScreen(BuildContext context);
}

/// A boundary marker used to enforce that screens are rendered within a master layout shell.
class AppShellBoundary extends InheritedWidget {
  const AppShellBoundary({super.key, required super.child});

  static bool isActive(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppShellBoundary>() !=
        null;
  }

  @override
  bool updateShouldNotify(AppShellBoundary oldWidget) => false;
}

/// The unified, high-fidelity definition of a PrimeCare screen.
/// This object is the single source of truth for routing, hydration, and rendering.
/// It merges the concepts of Intent, Config, and Definition.
class PrimeCareScreen extends AppScreenIntent {
  @override
  String get screenDescription =>
      'The screen requires proper layout management within the MasterLayout, user role handling, error monitoring, and responsive design for various devices.';

  @override
  List<String> get requiredComponents => const [
        'MasterLayout',
        'PrimeCareScreen',
        'ResponsiveScreenWrapper',
        'ErrorLog',
        'TaskSummary',
      ];

  @override
  List<String> get requiredFunctions => const [
        'buildScreen',
        'manageUserRoles',
        'handleError',
      ];

  @override
  final String name;

  @override
  final String title;

  @override
  final String subtitle;

  @override
  final PlatformRole? requiredRole;

  @override
  final dynamic provider;

  @override
  final ResiliencePolicy resiliencePolicy;

  @override
  final PlatformSubsystem? primarySubsystem;

  final String? _routeOverride;
  final IconData? icon;
  final WidgetBuilder? builder;

  PrimeCareScreen({
    String? name,
    required this.title,
    this.subtitle = '',
    this.requiredRole,
    this.provider,
    this.resiliencePolicy = const ResiliencePolicy(),
    this.primarySubsystem = PlatformSubsystem.metrics,
    this.icon,
    this.builder,
    String? route,
  }) : name = name ?? (route ?? '').split('/').last,
       _routeOverride = route;

  @override
  String get route => _routeOverride ?? '/$name';

  @override
  Widget build(BuildContext context) {
    assert(
      AppShellBoundary.isActive(context),
      'Layout Invariant Violation: All screens must be rendered within a MasterLayout shell. Direct routing without the shell is prohibited.',
    );

    if (builder != null) {
      return builder!(context);
    }

    return DefaultNotImplementedView(
      title: title,
      route: route,
      requiredRole: requiredRole,
    );
  }
}

class DefaultNotImplementedView extends GovernedStatelessWidget {
  @override
  String get screenDescription =>
      'This screen requires a structured layout with proper error handling, localization, and responsive design principles, while utilizing specific widget classes for implementation.';

  @override
  List<String> get requiredComponents => const [
        'MasterLayout',
        'GovernedConsumerWidget',
        'GovernedStatelessWidget',
        'GovernedConsumerState',
        'PrimeCareScreen',
        'DefaultNotImplementedView',
        'ResponsiveScreenWrapper',
      ];

  @override
  List<String> get requiredFunctions => const [
        'buildScreen',
        'checkAppShellBoundary',
        'handleLayoutViolations',
        'localizeText',
      ];

  final String title;
  final String route;
  final PlatformRole? requiredRole;

  const DefaultNotImplementedView({
    super.key,
    required this.title,
    required this.route,
    this.requiredRole,
  });

  @override
  Widget buildScreen(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Dynamic Mesh Gradient Background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withValues(alpha: 0.05),
                    theme.scaffoldBackgroundColor,
                    primaryColor.withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ),
          // Floating Decorative Elements
          _buildFloatingIcon(LucideIcons.code, 100, 100, 0.1),
          _buildFloatingIcon(LucideIcons.layers, 300, 150, 0.05),
          _buildFloatingIcon(LucideIcons.construction, 150, 400, 0.08),
          _buildFloatingIcon(LucideIcons.sparkles, 350, 500, 0.1),

          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value.clamp(0, 1),
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 500,
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.1),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.penTool,
                        size: 64,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      tr('governance.screen_under_construction'),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.hintColor,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 32),
                    _buildInfoRow(
                      context,
                      LucideIcons.mapPin,
                      tr('governance.route_label', args: [route]),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      context,
                      LucideIcons.shield,
                      tr(
                        'governance.role_label',
                        args: [requiredRole?.displayName ?? 'Public'],
                      ),
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(LucideIcons.arrowLeft, size: 18),
                      label: const Text('Back to Dashboard'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(
    IconData icon,
    double top,
    double left,
    double opacity,
  ) {
    return Positioned(
      top: top,
      left: left,
      child: Opacity(
        opacity: opacity,
        child: Icon(icon, size: 120),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.primaryColor),
        const SizedBox(width: 12),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
