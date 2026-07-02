// Governance - Category: state | Purpose: Riverpod state notifier for Trial Data Collection C R F
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrialDataCollectionCRFNotifier extends StateNotifier<AsyncValue<void>> {
  TrialDataCollectionCRFNotifier() : super(const AsyncValue.data(null));
}
