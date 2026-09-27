import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RpnMedicationsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnMedicationsNotifier extends StateNotifier<AsyncValue<void>> {
  RpnMedicationsNotifier() : super(const AsyncValue.data(null));
}
