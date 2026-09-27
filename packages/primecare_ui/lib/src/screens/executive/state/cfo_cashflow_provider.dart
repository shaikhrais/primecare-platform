import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoCashflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoCashflowNotifier extends StateNotifier<AsyncValue<void>> {
  CfoCashflowNotifier() : super(const AsyncValue.data(null));
}
