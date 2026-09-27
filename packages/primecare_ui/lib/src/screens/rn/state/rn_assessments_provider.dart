import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RnAssessmentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnAssessmentsNotifier extends StateNotifier<AsyncValue<void>> {
  RnAssessmentsNotifier() : super(const AsyncValue.data(null));
}
