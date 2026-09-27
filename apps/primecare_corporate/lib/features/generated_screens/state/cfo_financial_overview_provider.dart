// Governance - Category: state | Purpose: Riverpod state notifier for Cfo Financial Overview
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoFinancialOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  CfoFinancialOverviewNotifier() : super(const AsyncValue.data(null));
}
