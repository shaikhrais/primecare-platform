// Governance - Category: state | Purpose: Riverpod state notifier for CoordinatorWaitlistScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorWaitlistNotifier extends StateNotifier<AsyncValue<void>> {
  CoordinatorWaitlistNotifier() : super(const AsyncValue.data(null));
}
