// Governance - Category: state | Purpose: Riverpod state notifier for TreatmentPlanScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TreatmentPlanNotifier extends StateNotifier<AsyncValue<void>> {
  TreatmentPlanNotifier() : super(const AsyncValue.data(null));
}
