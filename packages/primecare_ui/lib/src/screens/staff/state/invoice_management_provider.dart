import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for InvoiceManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceManagementNotifier extends StateNotifier<AsyncValue<void>> {
  InvoiceManagementNotifier() : super(const AsyncValue.data(null));
}
