// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Region Performance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoRegionPerformanceNotifier extends StateNotifier<AsyncValue<void>> {
  CeoRegionPerformanceNotifier() : super(const AsyncValue.data(null));
}
