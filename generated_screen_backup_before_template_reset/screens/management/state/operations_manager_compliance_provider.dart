// Governance - Category: state | Purpose: Riverpod state notifier for OperationsManagerComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerComplianceNotifier() : super(const AsyncValue.data(null));
}
