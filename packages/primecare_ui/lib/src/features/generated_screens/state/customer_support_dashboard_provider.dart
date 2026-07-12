import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CustomerSupportDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSupportDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CustomerSupportDashboardNotifier() : super(const AsyncValue.data(null));
}
