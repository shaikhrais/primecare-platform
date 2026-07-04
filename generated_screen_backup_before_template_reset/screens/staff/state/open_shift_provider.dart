// Governance - Category: state | Purpose: Riverpod state notifier for OpenShiftScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OpenShiftNotifier extends StateNotifier<AsyncValue<void>> {
  OpenShiftNotifier() : super(const AsyncValue.data(null));
}
