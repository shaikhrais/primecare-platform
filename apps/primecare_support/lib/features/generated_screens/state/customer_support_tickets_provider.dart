// Governance - Category: state | Purpose: Riverpod state notifier for Customer Support Tickets
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomerSupportTicketsNotifier extends StateNotifier<AsyncValue<void>> {
  CustomerSupportTicketsNotifier() : super(const AsyncValue.data(null));
}
