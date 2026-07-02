// Governance - Category: state | Purpose: Riverpod state notifier for CaregiverVisitNotesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverVisitNotesNotifier extends StateNotifier<AsyncValue<void>> {
  CaregiverVisitNotesNotifier() : super(const AsyncValue.data(null));
}
