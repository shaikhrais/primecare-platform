// Governance - Category: state | Purpose: Riverpod state notifier for Mfa
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MfaNotifier extends StateNotifier<AsyncValue<void>> {
  MfaNotifier() : super(const AsyncValue.data(null));
}
