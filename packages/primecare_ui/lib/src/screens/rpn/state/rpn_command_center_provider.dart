// Governance - Category: state | Purpose: Riverpod state notifier for RpnCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  RpnCommandCenterNotifier() : super(const AsyncValue.data(null));
}
