import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for EnterpriseHealthScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterpriseHealthNotifier extends StateNotifier<AsyncValue<void>> {
  EnterpriseHealthNotifier() : super(const AsyncValue.data(null));
}
