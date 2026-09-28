// Governance - Category: state | Purpose: Riverpod state notifier for Cto Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CtoReportsNotifier extends StateNotifier<AsyncValue<void>> {
  CtoReportsNotifier() : super(const AsyncValue.data(null));
}
