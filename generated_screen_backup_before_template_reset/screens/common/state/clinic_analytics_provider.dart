// Governance - Category: state | Purpose: Riverpod state notifier for ClinicAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicAnalyticsNotifier() : super(const AsyncValue.data(null));
}
