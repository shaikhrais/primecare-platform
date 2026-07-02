// Governance - Category: state | Purpose: Riverpod state notifier for RnTasksScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnTasksNotifier extends StateNotifier<AsyncValue<void>> {
  RnTasksNotifier() : super(const AsyncValue.data(null));
}
