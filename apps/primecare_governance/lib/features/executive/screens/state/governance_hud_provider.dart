// Governance - Category: state | Purpose: Riverpod state notifier for Governance Hud
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class GovernanceHudNotifier extends StateNotifier<AsyncValue<void>> {
  GovernanceHudNotifier() : super(const AsyncValue.data(null));
}
