// Governance - Category: state | Purpose: Riverpod state notifier for Consent Management Console
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsentManagementConsoleNotifier extends StateNotifier<AsyncValue<void>> {
  ConsentManagementConsoleNotifier() : super(const AsyncValue.data(null));
}
