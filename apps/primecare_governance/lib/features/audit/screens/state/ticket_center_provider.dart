// Governance - Category: state | Purpose: Riverpod state notifier for Ticket Center
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TicketCenterNotifier extends StateNotifier<AsyncValue<void>> {
  TicketCenterNotifier() : super(const AsyncValue.data(null));
}
