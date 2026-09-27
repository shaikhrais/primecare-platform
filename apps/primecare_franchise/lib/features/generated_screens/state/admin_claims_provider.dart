// Governance - Category: state | Purpose: Riverpod state notifier for Admin Claims
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminClaimsNotifier extends StateNotifier<AsyncValue<void>> {
  AdminClaimsNotifier() : super(const AsyncValue.data(null));
}
