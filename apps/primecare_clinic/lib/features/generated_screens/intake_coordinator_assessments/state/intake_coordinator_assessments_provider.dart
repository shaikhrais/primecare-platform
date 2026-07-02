// Governance - Category: state | Purpose: Riverpod state notifier for Intake Coordinator Assessments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorAssessmentsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorAssessmentsNotifier() : super(const AsyncValue.data(null));
}
