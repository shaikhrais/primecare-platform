// Governance - Category: state | Purpose: Riverpod state notifier for OnboardingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingNotifier extends StateNotifier<AsyncValue<void>> {
  OnboardingNotifier() : super(const AsyncValue.data(null));
}
