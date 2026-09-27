import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for DeploymentCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeploymentCenterNotifier extends StateNotifier<AsyncValue<void>> {
  DeploymentCenterNotifier() : super(const AsyncValue.data(null));
}
