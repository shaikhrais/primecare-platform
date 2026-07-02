// Governance - Category: state | Purpose: Riverpod state notifier for Hr Applicants
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrApplicantsNotifier extends StateNotifier<AsyncValue<void>> {
  HrApplicantsNotifier() : super(const AsyncValue.data(null));
}
