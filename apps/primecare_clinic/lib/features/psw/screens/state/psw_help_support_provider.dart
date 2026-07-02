// Governance - Category: state | Purpose: Riverpod state notifier for Psw Help Support
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswHelpSupportNotifier extends StateNotifier<AsyncValue<void>> {
  PswHelpSupportNotifier() : super(const AsyncValue.data(null));
}
