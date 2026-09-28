// Governance - Category: state | Purpose: Riverpod state notifier for Risk Register
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RiskRegisterNotifier extends StateNotifier<AsyncValue<void>> {
  RiskRegisterNotifier() : super(const AsyncValue.data(null));
}
