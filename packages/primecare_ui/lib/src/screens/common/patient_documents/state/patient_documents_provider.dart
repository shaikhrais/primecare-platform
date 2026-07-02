// Governance - Category: state | Purpose: Riverpod state notifier for PatientDocumentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDocumentsNotifier extends StateNotifier<AsyncValue<void>> {
  PatientDocumentsNotifier() : super(const AsyncValue.data(null));
}
