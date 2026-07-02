// Governance - Category: state | Purpose: Riverpod state notifier for Hr Onboarding
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrOnboardingNotifier extends StateNotifier<AsyncValue<void>> {
  HrOnboardingNotifier() : super(const AsyncValue.data(null));
}
