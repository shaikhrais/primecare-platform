// Governance - Category: state | Purpose: Riverpod state notifier for Training Director Hub
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingDirectorHubNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorHubNotifier() : super(const AsyncValue.data(null));
}
