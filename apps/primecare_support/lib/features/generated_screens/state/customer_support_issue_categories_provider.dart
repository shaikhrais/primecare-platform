// Governance - Category: state | Purpose: Riverpod state notifier for Customer Support Issue Categories
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomerSupportIssueCategoriesNotifier extends StateNotifier<AsyncValue<void>> {
  CustomerSupportIssueCategoriesNotifier() : super(const AsyncValue.data(null));
}
