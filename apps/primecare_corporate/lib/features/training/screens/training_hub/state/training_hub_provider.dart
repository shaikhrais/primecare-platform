// Governance - Category: state | Purpose: Riverpod state notifier for Training Hub
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingHubNotifier() : super(const AsyncValue.data(null));
}
