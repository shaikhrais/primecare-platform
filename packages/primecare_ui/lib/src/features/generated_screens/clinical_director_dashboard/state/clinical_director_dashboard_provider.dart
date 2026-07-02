// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Director Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDirectorDashboardNotifier() : super(const AsyncValue.data(null));
}
