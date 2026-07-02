// Governance - Category: state | Purpose: Riverpod state notifier for Receptionist Calls
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistCallsNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistCallsNotifier() : super(const AsyncValue.data(null));
}
