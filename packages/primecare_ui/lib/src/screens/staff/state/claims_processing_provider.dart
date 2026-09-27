import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClaimsProcessingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClaimsProcessingNotifier extends StateNotifier<AsyncValue<void>> {
  ClaimsProcessingNotifier() : super(const AsyncValue.data(null));
}
