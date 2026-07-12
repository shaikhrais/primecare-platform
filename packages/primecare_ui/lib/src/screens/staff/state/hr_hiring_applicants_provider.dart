import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringApplicantsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringApplicantsNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringApplicantsNotifier() : super(const AsyncValue.data(null));
}
