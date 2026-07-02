// Governance - Category: state | Purpose: Riverpod state notifier for RiskManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiskManagementNotifier extends StateNotifier<AsyncValue<void>> {
  RiskManagementNotifier() : super(const AsyncValue.data(null));
}
