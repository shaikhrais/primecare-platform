import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoProfitabilityScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoProfitabilityNotifier extends StateNotifier<AsyncValue<void>> {
  CfoProfitabilityNotifier() : super(const AsyncValue.data(null));
}
