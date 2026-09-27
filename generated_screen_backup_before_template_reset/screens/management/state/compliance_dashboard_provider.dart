// Governance - Category: state | Purpose: Riverpod state notifier for ComplianceDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceDashboardNotifier() : super(const AsyncValue.data(null));
}
