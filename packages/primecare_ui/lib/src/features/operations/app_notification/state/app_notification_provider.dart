// Governance - Category: state | Purpose: Riverpod state notifier for App Notification
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppNotificationNotifier extends StateNotifier<AsyncValue<void>> {
  AppNotificationNotifier() : super(const AsyncValue.data(null));
}
