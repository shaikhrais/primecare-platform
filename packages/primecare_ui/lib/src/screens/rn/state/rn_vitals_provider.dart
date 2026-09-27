import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RnVitalsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnVitalsNotifier extends StateNotifier<AsyncValue<void>> {
  RnVitalsNotifier() : super(const AsyncValue.data(null));
}
