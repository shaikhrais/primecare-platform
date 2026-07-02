// Governance - Category: state | Purpose: Riverpod state notifier for Gamification Profile
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamificationProfileNotifier extends StateNotifier<AsyncValue<void>> {
  GamificationProfileNotifier() : super(const AsyncValue.data(null));
}
