// Governance - Category: state | Purpose: Riverpod state notifier for HrDirectorOnboardingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorOnboardingNotifier extends StateNotifier<AsyncValue<void>> {
  HrDirectorOnboardingNotifier() : super(const AsyncValue.data(null));
}
