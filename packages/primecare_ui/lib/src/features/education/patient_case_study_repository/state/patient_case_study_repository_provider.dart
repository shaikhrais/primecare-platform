// Governance - Category: state | Purpose: Riverpod state notifier for Patient Case Study Repository
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientCaseStudyRepositoryNotifier extends StateNotifier<AsyncValue<void>> {
  PatientCaseStudyRepositoryNotifier() : super(const AsyncValue.data(null));
}
