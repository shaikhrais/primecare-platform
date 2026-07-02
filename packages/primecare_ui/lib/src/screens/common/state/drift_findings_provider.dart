// Governance - Category: state | Purpose: Riverpod state notifier for DriftFindingsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DriftFindingsNotifier extends StateNotifier<AsyncValue<void>> {
  DriftFindingsNotifier() : super(const AsyncValue.data(null));
}
