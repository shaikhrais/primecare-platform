import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Vulnerable Population Registry
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VulnerablePopulationRegistryNotifier extends StateNotifier<AsyncValue<void>> {
  VulnerablePopulationRegistryNotifier() : super(const AsyncValue.data(null));
}
