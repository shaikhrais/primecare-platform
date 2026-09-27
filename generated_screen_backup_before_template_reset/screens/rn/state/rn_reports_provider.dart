// Governance - Category: state | Purpose: Riverpod state notifier for RnReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnReportsNotifier extends StateNotifier<AsyncValue<void>> {
  RnReportsNotifier() : super(const AsyncValue.data(null));
}
