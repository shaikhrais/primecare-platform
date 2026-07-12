import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HswScheduleScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswScheduleNotifier extends StateNotifier<AsyncValue<void>> {
  HswScheduleNotifier() : super(const AsyncValue.data(null));
}
