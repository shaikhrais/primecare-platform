import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for NursingTaskScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NursingTaskNotifier extends StateNotifier<AsyncValue<void>> {
  NursingTaskNotifier() : super(const AsyncValue.data(null));
}
