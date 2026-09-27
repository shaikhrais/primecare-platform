// Governance - Category: state | Purpose: Riverpod state notifier for LegalDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  LegalDashboardNotifier() : super(const AsyncValue.data(null));
}
