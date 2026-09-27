import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PendingTaskQueueScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingTaskQueueNotifier extends StateNotifier<AsyncValue<void>> {
  PendingTaskQueueNotifier() : super(const AsyncValue.data(null));
}
