// Governance - Category: state | Purpose: Riverpod state notifier for Nurse Practitioner (NP) Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NpAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  NpAnalyticsNotifier() : super(const AsyncValue.data(null));
}
