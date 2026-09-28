// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Revenue Summary
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CeoRevenueSummaryNotifier extends StateNotifier<AsyncValue<void>> {
  CeoRevenueSummaryNotifier() : super(const AsyncValue.data(null));
}
