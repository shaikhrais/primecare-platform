import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Prime Care
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimeCareNotifier extends StateNotifier<AsyncValue<void>> {
  PrimeCareNotifier() : super(const AsyncValue.data(null));
}
