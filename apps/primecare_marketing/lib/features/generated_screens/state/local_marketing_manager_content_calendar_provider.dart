// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Content Calendar
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LocalMarketingManagerContentCalendarNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerContentCalendarNotifier() : super(const AsyncValue.data(null));
}
