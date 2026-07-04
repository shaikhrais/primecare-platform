// Governance - Category: state | Purpose: Riverpod state notifier for SocialWorkerWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialWorkerWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  SocialWorkerWorkflowNotifier() : super(const AsyncValue.data(null));
}
