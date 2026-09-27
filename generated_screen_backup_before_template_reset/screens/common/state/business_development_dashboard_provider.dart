// Governance - Category: state | Purpose: Riverpod state notifier for BusinessDevelopmentDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessDevelopmentDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  BusinessDevelopmentDashboardNotifier() : super(const AsyncValue.data(null));
}
