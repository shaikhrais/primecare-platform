import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RmtExercisePlanScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtExercisePlanNotifier extends StateNotifier<AsyncValue<void>> {
  RmtExercisePlanNotifier() : super(const AsyncValue.data(null));
}
