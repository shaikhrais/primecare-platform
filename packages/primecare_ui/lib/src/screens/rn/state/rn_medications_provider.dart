import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RnMedicationsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnMedicationsNotifier extends StateNotifier<AsyncValue<void>> {
  RnMedicationsNotifier() : super(const AsyncValue.data(null));
}
