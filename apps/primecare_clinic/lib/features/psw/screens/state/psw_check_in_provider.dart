// Governance - Category: state | Purpose: Riverpod state notifier for Psw Check In
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswCheckInNotifier extends StateNotifier<AsyncValue<void>> {
  PswCheckInNotifier() : super(const AsyncValue.data(null));
}
