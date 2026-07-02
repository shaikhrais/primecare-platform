// Governance - Category: state | Purpose: Riverpod state notifier for FollowupScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FollowupNotifier extends StateNotifier<AsyncValue<void>> {
  FollowupNotifier() : super(const AsyncValue.data(null));
}
