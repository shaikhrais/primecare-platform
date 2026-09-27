import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RnPatientChartingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnPatientChartingNotifier extends StateNotifier<AsyncValue<void>> {
  RnPatientChartingNotifier() : super(const AsyncValue.data(null));
}
