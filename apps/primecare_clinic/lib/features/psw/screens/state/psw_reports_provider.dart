// Governance - Category: state | Purpose: Riverpod state notifier for Psw Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PswReportsNotifier extends StateNotifier<AsyncValue<void>> {
  PswReportsNotifier() : super(const AsyncValue.data(null));
}
