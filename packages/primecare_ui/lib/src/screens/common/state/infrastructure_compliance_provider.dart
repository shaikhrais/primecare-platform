import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for InfrastructureComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfrastructureComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  InfrastructureComplianceNotifier() : super(const AsyncValue.data(null));
}
