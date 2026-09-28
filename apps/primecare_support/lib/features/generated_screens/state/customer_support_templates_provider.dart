// Governance - Category: state | Purpose: Riverpod state notifier for Customer Support Templates
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomerSupportTemplatesNotifier extends StateNotifier<AsyncValue<void>> {
  CustomerSupportTemplatesNotifier() : super(const AsyncValue.data(null));
}
