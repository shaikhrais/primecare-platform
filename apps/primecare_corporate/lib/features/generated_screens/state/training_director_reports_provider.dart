// Governance - Category: state | Purpose: Riverpod state notifier for Training Director Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorReportsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorReportsNotifier() : super(const AsyncValue.data(null));
}
