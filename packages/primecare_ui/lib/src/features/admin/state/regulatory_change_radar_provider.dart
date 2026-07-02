// Governance - Category: state | Purpose: Riverpod state notifier for Regulatory Change Radar
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegulatoryChangeRadarNotifier extends StateNotifier<AsyncValue<void>> {
  RegulatoryChangeRadarNotifier() : super(const AsyncValue.data(null));
}
