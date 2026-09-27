import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorWorkflowNotifier() : super(const AsyncValue.data(null));
}
