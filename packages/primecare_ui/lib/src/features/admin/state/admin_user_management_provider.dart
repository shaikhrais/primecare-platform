// Governance - Category: state | Purpose: Riverpod state notifier for Admin User Management
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminUserManagementNotifier extends StateNotifier<AsyncValue<void>> {
  AdminUserManagementNotifier() : super(const AsyncValue.data(null));
}
