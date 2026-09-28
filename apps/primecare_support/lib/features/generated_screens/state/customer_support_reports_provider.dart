// Governance - Category: state | Purpose: Riverpod state notifier for Customer Support Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomerSupportReportsNotifier extends StateNotifier<AsyncValue<void>> {
  CustomerSupportReportsNotifier() : super(const AsyncValue.data(null));
}
