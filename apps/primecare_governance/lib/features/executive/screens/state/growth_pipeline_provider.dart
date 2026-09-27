// Governance - Category: state | Purpose: Riverpod state notifier for Growth Pipeline
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GrowthPipelineNotifier extends StateNotifier<AsyncValue<void>> {
  GrowthPipelineNotifier() : super(const AsyncValue.data(null));
}
