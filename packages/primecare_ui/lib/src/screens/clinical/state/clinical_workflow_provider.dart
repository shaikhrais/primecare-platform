import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalWorkflowNotifier() : super(const AsyncValue.data(null));
}
