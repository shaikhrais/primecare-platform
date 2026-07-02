// Governance - Category: state | Purpose: Riverpod state notifier for QaWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  QaWorkflowNotifier() : super(const AsyncValue.data(null));
}
