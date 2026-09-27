import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RevenueScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueNotifier extends StateNotifier<AsyncValue<void>> {
  RevenueNotifier() : super(const AsyncValue.data(null));
}
