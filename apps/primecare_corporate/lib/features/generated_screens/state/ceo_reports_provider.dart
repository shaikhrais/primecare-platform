// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoReportsNotifier extends StateNotifier<AsyncValue<void>> {
  CeoReportsNotifier() : super(const AsyncValue.data(null));
}
