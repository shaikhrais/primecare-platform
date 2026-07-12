import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RpnPatientChartingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnPatientChartingNotifier extends StateNotifier<AsyncValue<void>> {
  RpnPatientChartingNotifier() : super(const AsyncValue.data(null));
}
