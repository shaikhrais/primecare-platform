// Governance - Category: state | Purpose: Riverpod state notifier for ClientProgressScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientProgressNotifier extends StateNotifier<AsyncValue<void>> {
  ClientProgressNotifier() : super(const AsyncValue.data(null));
}
