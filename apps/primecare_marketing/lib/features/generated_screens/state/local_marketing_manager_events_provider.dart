// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Events
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerEventsNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerEventsNotifier() : super(const AsyncValue.data(null));
}
