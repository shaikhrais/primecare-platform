// Governance - Category: state | Purpose: Riverpod state notifier for PolicyManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolicyManagementNotifier extends StateNotifier<AsyncValue<void>> {
  PolicyManagementNotifier() : super(const AsyncValue.data(null));
}
