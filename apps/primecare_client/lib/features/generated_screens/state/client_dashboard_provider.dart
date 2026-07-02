// Governance - Category: state | Purpose: Riverpod state notifier for Client Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ClientDashboardNotifier() : super(const AsyncValue.data(null));
}
