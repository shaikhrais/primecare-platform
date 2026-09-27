import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Psw Client Profile
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswClientProfileNotifier extends StateNotifier<AsyncValue<void>> {
  PswClientProfileNotifier() : super(const AsyncValue.data(null));
}
