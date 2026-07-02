// Governance - Category: state | Purpose: Riverpod state notifier for HswCarePlansScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HswCarePlansNotifier extends StateNotifier<AsyncValue<void>> {
  HswCarePlansNotifier() : super(const AsyncValue.data(null));
}
