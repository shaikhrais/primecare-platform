// Governance - Category: state | Purpose: Riverpod state notifier for Policies
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoliciesNotifier extends StateNotifier<AsyncValue<void>> {
  PoliciesNotifier() : super(const AsyncValue.data(null));
}
