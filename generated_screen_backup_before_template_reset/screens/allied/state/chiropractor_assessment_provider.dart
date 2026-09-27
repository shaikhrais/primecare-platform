// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorAssessmentScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAssessmentNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorAssessmentNotifier() : super(const AsyncValue.data(null));
}
