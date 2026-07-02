// Governance - Category: state | Purpose: Riverpod state notifier for Informed Consent Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InformedConsentTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  InformedConsentTrackerNotifier() : super(const AsyncValue.data(null));
}
