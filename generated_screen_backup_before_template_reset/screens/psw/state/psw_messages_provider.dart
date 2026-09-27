// Governance - Category: state | Purpose: Riverpod state notifier for Messages
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMessagesNotifier extends StateNotifier<AsyncValue<void>> {
  PswMessagesNotifier() : super(const AsyncValue.data(null));
}
