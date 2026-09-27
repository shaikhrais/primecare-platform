// Governance - Category: state | Purpose: Riverpod state notifier for RpnReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnReportsNotifier extends StateNotifier<AsyncValue<void>> {
  RpnReportsNotifier() : super(const AsyncValue.data(null));
}
