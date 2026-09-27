// Governance - Category: state | Purpose: Riverpod state notifier for Psw Messaging
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswMessagingNotifier extends StateNotifier<AsyncValue<void>> {
  PswMessagingNotifier() : super(const AsyncValue.data(null));
}
