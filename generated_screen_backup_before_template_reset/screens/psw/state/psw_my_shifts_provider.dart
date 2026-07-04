// Governance - Category: state | Purpose: Riverpod state notifier for Psw My Shifts
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMyShiftsNotifier extends StateNotifier<AsyncValue<void>> {
  PswMyShiftsNotifier() : super(const AsyncValue.data(null));
}
