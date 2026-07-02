// Governance - Category: state | Purpose: Riverpod state notifier for Consent
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsentNotifier extends StateNotifier<AsyncValue<void>> {
  ConsentNotifier() : super(const AsyncValue.data(null));
}
