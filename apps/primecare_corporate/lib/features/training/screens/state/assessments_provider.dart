// Governance - Category: state | Purpose: Riverpod state notifier for Assessments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AssessmentsNotifier extends StateNotifier<AsyncValue<void>> {
  AssessmentsNotifier() : super(const AsyncValue.data(null));
}
