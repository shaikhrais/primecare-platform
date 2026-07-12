import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Therapist Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  TherapistAnalyticsNotifier() : super(const AsyncValue.data(null));
}
