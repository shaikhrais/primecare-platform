// Governance - Category: state | Purpose: Riverpod state notifier for Coo Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooReportsNotifier extends StateNotifier<AsyncValue<void>> {
  CooReportsNotifier() : super(const AsyncValue.data(null));
}
