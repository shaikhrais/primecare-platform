import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CredentialExpiryScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CredentialExpiryNotifier extends StateNotifier<AsyncValue<void>> {
  CredentialExpiryNotifier() : super(const AsyncValue.data(null));
}
