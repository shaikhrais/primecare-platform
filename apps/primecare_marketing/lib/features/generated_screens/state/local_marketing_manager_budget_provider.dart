// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Budget
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LocalMarketingManagerBudgetNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerBudgetNotifier() : super(const AsyncValue.data(null));
}
