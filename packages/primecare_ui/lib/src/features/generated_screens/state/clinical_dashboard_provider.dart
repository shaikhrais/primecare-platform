// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDashboardNotifier() : super(const AsyncValue.data(null));
}
