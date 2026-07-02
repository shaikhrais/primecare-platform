// Governance - Category: state | Purpose: Riverpod state notifier for RmtClientIntakeScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtClientIntakeNotifier extends StateNotifier<AsyncValue<void>> {
  RmtClientIntakeNotifier() : super(const AsyncValue.data(null));
}
