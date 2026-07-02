// Governance - Category: state | Purpose: Riverpod state notifier for OnboardingChecklistScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingChecklistNotifier extends StateNotifier<AsyncValue<void>> {
  OnboardingChecklistNotifier() : super(const AsyncValue.data(null));
}
