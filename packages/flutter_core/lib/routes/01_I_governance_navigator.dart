// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../registry/intents/01_I_app_screen_intent.dart';

/// A high-fidelity navigator that enforces platform governance policies.
/// Instead of navigating to raw strings, it uses [AppScreenIntent] to ensure
/// that security, dependencies, and resilience policies are respected.
class GovernanceNavigator {
  final Ref ref;
  final BuildContext context;

  GovernanceNavigator(this.ref, this.context);

  /// Navigates to a screen defined by its [AppScreenIntent].
  /// Performs a pre-flight health check before proceeding.
  void navigateTo(AppScreenIntent intent) {
    // 1. Audit Dependency Health
    final health = intent.verifyReady(ref);
    
    if (!health.isReady) {
      debugPrint('Governance Block: ${health.message}');
      
      // Apply Resilience Policy: Redirect if unhealthy
      if (intent.resiliencePolicy.strategy == ScreenRecoveryStrategy.fallbackRedirect && 
          intent.resiliencePolicy.fallbackRoute != null) {
        context.go(intent.resiliencePolicy.fallbackRoute!);
        return;
      }
      
      // Fallback: Show system recovery or a simple snackbar in debug
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot navigate: ${health.message}'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 2. Perform Navigation
    context.go(intent.route);
  }

  /// Navigates back, respecting any governance-defined stack rules.
  void goBack() {
    if (context.canPop()) {
      context.pop();
    }
  }
}

/// Provider for the GovernanceNavigator.
final governanceNavigatorProvider = Provider.family<GovernanceNavigator, BuildContext>((ref, context) {
  return GovernanceNavigator(ref, context);
});
