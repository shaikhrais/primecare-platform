import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Secure Message Center
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecureMessageCenterNotifier extends StateNotifier<AsyncValue<void>> {
  SecureMessageCenterNotifier() : super(const AsyncValue.data(null));
}
