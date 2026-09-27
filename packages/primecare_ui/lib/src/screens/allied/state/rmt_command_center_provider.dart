import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RmtCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  RmtCommandCenterNotifier() : super(const AsyncValue.data(null));
}
