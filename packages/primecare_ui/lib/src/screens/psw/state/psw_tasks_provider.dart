import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Task List
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswTasksNotifier extends StateNotifier<AsyncValue<void>> {
  PswTasksNotifier() : super(const AsyncValue.data(null));
}
