import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RpnWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  RpnWorkflowNotifier() : super(const AsyncValue.data(null));
}
