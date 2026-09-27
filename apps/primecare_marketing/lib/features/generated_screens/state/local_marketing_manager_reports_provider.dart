// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerReportsNotifier() : super(const AsyncValue.data(null));
}
