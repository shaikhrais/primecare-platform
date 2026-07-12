import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Residency Program Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResidencyProgramTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  ResidencyProgramTrackerNotifier() : super(const AsyncValue.data(null));
}
