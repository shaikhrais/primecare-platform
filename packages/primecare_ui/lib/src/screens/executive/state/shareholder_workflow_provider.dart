import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ShareholderWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  ShareholderWorkflowNotifier() : super(const AsyncValue.data(null));
}
