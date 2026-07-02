// Governance - Category: state | Purpose: Riverpod state notifier for Shift Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswShiftTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  PswShiftTrackerNotifier() : super(const AsyncValue.data(null));
}
