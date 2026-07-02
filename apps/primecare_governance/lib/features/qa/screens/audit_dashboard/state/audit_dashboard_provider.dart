// Governance - Category: state | Purpose: Riverpod state notifier for Audit Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  AuditDashboardNotifier() : super(const AsyncValue.data(null));
}
