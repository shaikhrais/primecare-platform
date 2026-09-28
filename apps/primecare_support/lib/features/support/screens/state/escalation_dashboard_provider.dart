// Governance - Category: state | Purpose: Riverpod state notifier for Escalation Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class EscalationDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  EscalationDashboardNotifier() : super(const AsyncValue.data(null));
}
