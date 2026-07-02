// Governance - Category: state | Purpose: Riverpod state notifier for Patient Retention Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientRetentionAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  PatientRetentionAnalyticsNotifier() : super(const AsyncValue.data(null));
}
