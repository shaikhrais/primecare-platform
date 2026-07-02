// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalDirectorReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorReportsNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDirectorReportsNotifier() : super(const AsyncValue.data(null));
}
