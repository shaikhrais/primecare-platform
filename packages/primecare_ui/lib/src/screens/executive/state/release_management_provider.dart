// Governance - Category: state | Purpose: Riverpod state notifier for ReleaseManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReleaseManagementNotifier extends StateNotifier<AsyncValue<void>> {
  ReleaseManagementNotifier() : super(const AsyncValue.data(null));
}
