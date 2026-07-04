// Governance - Category: state | Purpose: Riverpod state notifier for ApiHealthDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiHealthDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ApiHealthDashboardNotifier() : super(const AsyncValue.data(null));
}
