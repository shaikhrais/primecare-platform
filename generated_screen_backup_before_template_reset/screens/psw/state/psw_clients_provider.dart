// Governance - Category: state | Purpose: Riverpod state notifier for My Clients
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswClientsNotifier extends StateNotifier<AsyncValue<void>> {
  PswClientsNotifier() : super(const AsyncValue.data(null));
}
