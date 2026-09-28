// Governance - Category: state | Purpose: Riverpod state notifier for Psw Notifications
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PswNotificationsNotifier extends StateNotifier<AsyncValue<void>> {
  PswNotificationsNotifier() : super(const AsyncValue.data(null));
}
