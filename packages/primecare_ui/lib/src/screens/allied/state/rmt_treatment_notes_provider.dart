// Governance - Category: state | Purpose: Riverpod state notifier for RmtTreatmentNotesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtTreatmentNotesNotifier extends StateNotifier<AsyncValue<void>> {
  RmtTreatmentNotesNotifier() : super(const AsyncValue.data(null));
}
