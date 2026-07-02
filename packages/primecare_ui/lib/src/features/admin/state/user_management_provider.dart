// Governance - Category: state | Purpose: Riverpod state notifier for User Management
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserManagementNotifier extends StateNotifier<AsyncValue<void>> {
  UserManagementNotifier() : super(const AsyncValue.data(null));
}
