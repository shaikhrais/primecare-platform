import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CooCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  CooCommandCenterNotifier() : super(const AsyncValue.data(null));
}
