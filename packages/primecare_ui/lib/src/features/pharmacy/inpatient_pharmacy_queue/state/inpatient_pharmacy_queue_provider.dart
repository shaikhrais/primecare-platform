// Governance - Category: state | Purpose: Riverpod state notifier for Inpatient Pharmacy Queue
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InpatientPharmacyQueueNotifier extends StateNotifier<AsyncValue<void>> {
  InpatientPharmacyQueueNotifier() : super(const AsyncValue.data(null));
}
