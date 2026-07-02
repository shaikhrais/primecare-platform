// Governance - Category: state | Purpose: Riverpod state notifier for RnCarePlansScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnCarePlansNotifier extends StateNotifier<AsyncValue<void>> {
  RnCarePlansNotifier() : super(const AsyncValue.data(null));
}
