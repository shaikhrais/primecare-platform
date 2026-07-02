// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Shifts
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerShiftsNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerShiftsNotifier() : super(const AsyncValue.data(null));
}
