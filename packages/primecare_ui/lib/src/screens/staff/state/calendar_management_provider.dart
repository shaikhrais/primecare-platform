import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CalendarManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarManagementNotifier extends StateNotifier<AsyncValue<void>> {
  CalendarManagementNotifier() : super(const AsyncValue.data(null));
}
