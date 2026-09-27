// Governance - Category: state | Purpose: Riverpod state notifier for StaffManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StaffManagementNotifier extends StateNotifier<AsyncValue<void>> {
  StaffManagementNotifier() : super(const AsyncValue.data(null));
}
