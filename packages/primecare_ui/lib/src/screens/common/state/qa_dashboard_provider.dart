import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for QaDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  QaDashboardNotifier() : super(const AsyncValue.data(null));
}
