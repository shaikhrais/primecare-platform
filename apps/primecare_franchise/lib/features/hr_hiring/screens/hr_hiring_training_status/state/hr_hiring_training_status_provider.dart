// Governance - Category: state | Purpose: Riverpod state notifier for Hr Hiring Training Status
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringTrainingStatusNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringTrainingStatusNotifier() : super(const AsyncValue.data(null));
}
