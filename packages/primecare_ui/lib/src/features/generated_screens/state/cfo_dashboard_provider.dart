// Governance - Category: state | Purpose: Riverpod state notifier for CfoDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CfoDashboardNotifier() : super(const AsyncValue.data(null));
}
