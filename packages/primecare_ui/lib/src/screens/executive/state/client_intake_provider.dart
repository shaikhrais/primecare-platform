import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClientIntakeScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientIntakeNotifier extends StateNotifier<AsyncValue<void>> {
  ClientIntakeNotifier() : super(const AsyncValue.data(null));
}
