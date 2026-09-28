// Governance - Category: state | Purpose: Riverpod state notifier for Psw Task List
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PswTaskListNotifier extends StateNotifier<AsyncValue<void>> {
  PswTaskListNotifier() : super(const AsyncValue.data(null));
}
