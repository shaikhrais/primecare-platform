import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorClientIntakeScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorClientIntakeNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorClientIntakeNotifier() : super(const AsyncValue.data(null));
}
