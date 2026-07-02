// Governance - Category: state | Purpose: Riverpod state notifier for Crisis Protocol Trigger
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CrisisProtocolTriggerNotifier extends StateNotifier<AsyncValue<void>> {
  CrisisProtocolTriggerNotifier() : super(const AsyncValue.data(null));
}
