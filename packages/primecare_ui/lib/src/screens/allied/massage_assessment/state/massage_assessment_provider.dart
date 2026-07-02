// Governance - Category: state | Purpose: Riverpod state notifier for MassageAssessmentScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MassageAssessmentNotifier extends StateNotifier<AsyncValue<void>> {
  MassageAssessmentNotifier() : super(const AsyncValue.data(null));
}
