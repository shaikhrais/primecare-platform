// Layer: 01_INFRASTRUCTURE
import '../registry/platform_role.dart';
import '../registry/intents/app_screen_intent.dart';
import 'platform_types.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning_amber_rounded, size: 48, color: Colors.orange),
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
