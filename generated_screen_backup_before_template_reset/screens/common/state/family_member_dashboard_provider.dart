// Governance - Category: state | Purpose: Riverpod state notifier for FamilyMemberDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberDashboardNotifier() : super(const AsyncValue.data(null));
}
