import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropracticAssessmentScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropracticAssessmentNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropracticAssessmentNotifier() : super(const AsyncValue.data(null));
}
