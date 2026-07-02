// Governance - Category: state | Purpose: Riverpod state notifier for Psw Observation Vitals Log
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswObservationVitalsLogNotifier extends StateNotifier<AsyncValue<void>> {
  PswObservationVitalsLogNotifier() : super(const AsyncValue.data(null));
}
