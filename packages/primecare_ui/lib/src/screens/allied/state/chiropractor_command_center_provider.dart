import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorCommandCenterNotifier() : super(const AsyncValue.data(null));
}
