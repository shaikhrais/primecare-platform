import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorReportsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorReportsNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorReportsNotifier() : super(const AsyncValue.data(null));
}
