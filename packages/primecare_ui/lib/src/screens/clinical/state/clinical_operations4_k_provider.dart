import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalOperations4KScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalOperations4KNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalOperations4KNotifier() : super(const AsyncValue.data(null));
}
