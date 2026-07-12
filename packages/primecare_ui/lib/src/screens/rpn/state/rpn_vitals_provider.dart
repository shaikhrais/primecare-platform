import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RpnVitalsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnVitalsNotifier extends StateNotifier<AsyncValue<void>> {
  RpnVitalsNotifier() : super(const AsyncValue.data(null));
}
