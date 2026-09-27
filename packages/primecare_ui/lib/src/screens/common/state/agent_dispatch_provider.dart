import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for AgentDispatchScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AgentDispatchNotifier extends StateNotifier<AsyncValue<void>> {
  AgentDispatchNotifier() : super(const AsyncValue.data(null));
}
