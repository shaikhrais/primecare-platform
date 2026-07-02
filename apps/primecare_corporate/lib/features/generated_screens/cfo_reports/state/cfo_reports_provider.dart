// Governance - Category: state | Purpose: Riverpod state notifier for Cfo Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoReportsNotifier extends StateNotifier<AsyncValue<void>> {
  CfoReportsNotifier() : super(const AsyncValue.data(null));
}
