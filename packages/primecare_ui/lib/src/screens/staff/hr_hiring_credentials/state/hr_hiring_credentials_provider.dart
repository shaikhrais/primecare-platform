// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringCredentialsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringCredentialsNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringCredentialsNotifier() : super(const AsyncValue.data(null));
}
