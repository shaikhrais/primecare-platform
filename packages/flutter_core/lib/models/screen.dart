// Layer: 01_INFRASTRUCTURE
import '../registry/platform_role.dart';
import '../registry/intents/app_screen_intent.dart';
import 'platform_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

/// Base class for governed consumer widgets.
/// Enforces layout invariants by making it impossible to render directly to a route.
abstract class GovernedConsumerWidget extends ConsumerWidget {
  const GovernedConsumerWidget({super.key});

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
    return buildScreen(context, ref);
  }

  /// Override this instead of [build] to implement the screen UI.
  Widget buildScreen(BuildContext context, WidgetRef ref);
}

/// Base class for governed stateless widgets.
/// Enforces layout invariants by making it impossible to render directly to a route.
abstract class GovernedStatelessWidget extends StatelessWidget {
  const GovernedStatelessWidget({super.key});

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
    return buildScreen(context);
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
    extends ConsumerState<T> {
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
    return buildScreen(context);
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

  PrimeCareScreen({
    String? name,
    required this.title,
    this.subtitle = '',
    this.requiredRole,
    this.provider,
    this.resiliencePolicy = const ResiliencePolicy(),
    this.primarySubsystem = PlatformSubsystem.metrics,
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

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 48,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              'Screen is registered but not implemented yet.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Route: $route'),
            Text('Role: ${requiredRole?.name ?? "Public"}'),
          ],
        ),
      ),
    );
  }
}
