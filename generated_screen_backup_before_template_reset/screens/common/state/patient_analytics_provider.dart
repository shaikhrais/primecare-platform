// Governance - Category: state | Purpose: Riverpod state notifier for PatientAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  PatientAnalyticsNotifier() : super(const AsyncValue.data(null));
}
