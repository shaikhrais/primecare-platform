// Governance - Category: state | Purpose: Riverpod state notifier for Psw My Clients
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMyClientsNotifier extends StateNotifier<AsyncValue<void>> {
  PswMyClientsNotifier() : super(const AsyncValue.data(null));
}
