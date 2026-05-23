// Governance - Category: view | Purpose: Layer: 01_INFRASTRUCTURE A high-fidelity skeleton widget for governed screens. This widget throws an [UnimplementedGo...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import '../intents/app_screen_intent.dart';

/// A high-fidelity skeleton widget for governed screens.
/// This widget throws an [UnimplementedGovernanceException] when built,
/// ensuring that developers are aware of missing implementations.
class GovernanceSkeleton extends StatelessWidget {
  final String featureName;
  final String componentName;

  const GovernanceSkeleton({
    super.key,
    required this.featureName,
    this.componentName = 'Screen',
  });

  @override
  Widget build(BuildContext context) {
    // In debug mode, we throw to make it obvious.
    // In production, we would show a branded "Coming Soon" or "Under Maintenance" view.
    throw UnimplementedGovernanceException(featureName, componentName);
  }
}
