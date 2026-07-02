// Governance - Category: state | Purpose: Riverpod state notifier for Board Of Directors Summary
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardOfDirectorsSummaryNotifier extends StateNotifier<AsyncValue<void>> {
  BoardOfDirectorsSummaryNotifier() : super(const AsyncValue.data(null));
}
