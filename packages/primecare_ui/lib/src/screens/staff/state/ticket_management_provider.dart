import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for TicketManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketManagementNotifier extends StateNotifier<AsyncValue<void>> {
  TicketManagementNotifier() : super(const AsyncValue.data(null));
}
