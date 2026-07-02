// Governance - Category: state | Purpose: Riverpod state notifier for Psw Profile
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswProfileNotifier extends StateNotifier<AsyncValue<void>> {
  PswProfileNotifier() : super(const AsyncValue.data(null));
}
