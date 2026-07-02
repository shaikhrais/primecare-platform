// Governance - Category: state | Purpose: Riverpod state notifier for Lead Pipeline
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadPipelineNotifier extends StateNotifier<AsyncValue<void>> {
  LeadPipelineNotifier() : super(const AsyncValue.data(null));
}
