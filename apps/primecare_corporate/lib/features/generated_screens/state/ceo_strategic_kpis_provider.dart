// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Strategic Kpis
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoStrategicKpisNotifier extends StateNotifier<AsyncValue<void>> {
  CeoStrategicKpisNotifier() : super(const AsyncValue.data(null));
}
