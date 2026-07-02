// Governance - Category: state | Purpose: Riverpod state notifier for Family Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyDashboardNotifier() : super(const AsyncValue.data(null));
}
