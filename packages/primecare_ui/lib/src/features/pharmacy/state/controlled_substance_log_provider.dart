// Governance - Category: state | Purpose: Riverpod state notifier for Controlled Substance Log
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlledSubstanceLogNotifier extends StateNotifier<AsyncValue<void>> {
  ControlledSubstanceLogNotifier() : super(const AsyncValue.data(null));
}
