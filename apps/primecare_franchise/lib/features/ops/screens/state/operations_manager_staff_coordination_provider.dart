// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Staff Coordination
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerStaffCoordinationNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerStaffCoordinationNotifier() : super(const AsyncValue.data(null));
}
