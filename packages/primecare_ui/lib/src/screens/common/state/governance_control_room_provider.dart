import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GovernanceControlRoomScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceControlRoomNotifier extends StateNotifier<AsyncValue<void>> {
  GovernanceControlRoomNotifier() : super(const AsyncValue.data(null));
}
