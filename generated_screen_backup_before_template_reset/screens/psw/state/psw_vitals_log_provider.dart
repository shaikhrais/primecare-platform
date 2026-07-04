// Governance - Category: state | Purpose: Riverpod state notifier for Vitals Entry
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswVitalsLogNotifier extends StateNotifier<AsyncValue<void>> {
  PswVitalsLogNotifier() : super(const AsyncValue.data(null));
}
