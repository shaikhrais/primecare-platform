import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CooSchedulingHealthScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooSchedulingHealthNotifier extends StateNotifier<AsyncValue<void>> {
  CooSchedulingHealthNotifier() : super(const AsyncValue.data(null));
}
