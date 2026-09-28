// Governance - Category: state | Purpose: Riverpod state notifier for Security Hub
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SecurityHubNotifier extends StateNotifier<AsyncValue<void>> {
  SecurityHubNotifier() : super(const AsyncValue.data(null));
}
