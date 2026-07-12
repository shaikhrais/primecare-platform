import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Role Access Matrix
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleAccessMatrixNotifier extends StateNotifier<AsyncValue<void>> {
  RoleAccessMatrixNotifier() : super(const AsyncValue.data(null));
}
