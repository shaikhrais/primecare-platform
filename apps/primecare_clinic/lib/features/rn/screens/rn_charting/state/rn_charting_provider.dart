// Governance - Category: state | Purpose: Riverpod state notifier for Rn Charting
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnChartingNotifier extends StateNotifier<AsyncValue<void>> {
  RnChartingNotifier() : super(const AsyncValue.data(null));
}
