import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrDirectorTrainingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorTrainingNotifier extends StateNotifier<AsyncValue<void>> {
  HrDirectorTrainingNotifier() : super(const AsyncValue.data(null));
}
