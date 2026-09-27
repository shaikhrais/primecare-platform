// Governance - Category: state | Purpose: Riverpod state notifier for Client Treatment History
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientTreatmentHistoryNotifier extends StateNotifier<AsyncValue<void>> {
  ClientTreatmentHistoryNotifier() : super(const AsyncValue.data(null));
}
