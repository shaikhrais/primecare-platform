// Governance - Category: state | Purpose: Riverpod state notifier for AdjustmentNotesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdjustmentNotesNotifier extends StateNotifier<AsyncValue<void>> {
  AdjustmentNotesNotifier() : super(const AsyncValue.data(null));
}
