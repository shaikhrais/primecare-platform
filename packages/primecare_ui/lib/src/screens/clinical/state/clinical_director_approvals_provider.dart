// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalDirectorApprovalsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorApprovalsNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDirectorApprovalsNotifier() : super(const AsyncValue.data(null));
}
