// Governance - Category: state | Purpose: Riverpod state notifier for Employee Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  EmployeeAnalyticsNotifier() : super(const AsyncValue.data(null));
}
