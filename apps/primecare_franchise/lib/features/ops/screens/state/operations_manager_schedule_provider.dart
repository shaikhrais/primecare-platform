// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Schedule
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerScheduleNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerScheduleNotifier() : super(const AsyncValue.data(null));
}
