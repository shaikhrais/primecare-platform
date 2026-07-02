// Governance - Category: state | Purpose: Riverpod state notifier for Training Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingReportsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingReportsNotifier() : super(const AsyncValue.data(null));
}
