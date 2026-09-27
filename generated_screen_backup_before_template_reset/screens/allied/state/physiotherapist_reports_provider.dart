// Governance - Category: state | Purpose: Riverpod state notifier for PhysiotherapistReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistReportsNotifier extends StateNotifier<AsyncValue<void>> {
  PhysiotherapistReportsNotifier() : super(const AsyncValue.data(null));
}
