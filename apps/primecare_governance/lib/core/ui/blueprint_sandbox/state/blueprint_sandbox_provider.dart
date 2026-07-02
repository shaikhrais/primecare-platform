// Governance - Category: state | Purpose: Riverpod state notifier for Blueprint Sandbox
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BlueprintSandboxNotifier extends StateNotifier<AsyncValue<void>> {
  BlueprintSandboxNotifier() : super(const AsyncValue.data(null));
}
