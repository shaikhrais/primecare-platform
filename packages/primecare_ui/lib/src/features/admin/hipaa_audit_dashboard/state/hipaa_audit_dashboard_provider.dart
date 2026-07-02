// Governance - Category: state | Purpose: Riverpod state notifier for Hipaa Audit Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HipaaAuditDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HipaaAuditDashboardNotifier() : super(const AsyncValue.data(null));
}
