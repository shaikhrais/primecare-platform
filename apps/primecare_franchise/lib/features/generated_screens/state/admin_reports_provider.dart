// Governance - Category: state | Purpose: Riverpod state notifier for Admin Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminReportsNotifier extends StateNotifier<AsyncValue<void>> {
  AdminReportsNotifier() : super(const AsyncValue.data(null));
}
