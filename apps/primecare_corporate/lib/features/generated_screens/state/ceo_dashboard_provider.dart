// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CeoDashboardNotifier() : super(const AsyncValue.data(null));
}
