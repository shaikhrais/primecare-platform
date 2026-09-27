import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for EmployeeRecordsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeRecordsNotifier extends StateNotifier<AsyncValue<void>> {
  EmployeeRecordsNotifier() : super(const AsyncValue.data(null));
}
