// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringOnboardingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringOnboardingNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringOnboardingNotifier() : super(const AsyncValue.data(null));
}
