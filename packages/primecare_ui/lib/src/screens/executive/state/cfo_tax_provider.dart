import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoTaxScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoTaxNotifier extends StateNotifier<AsyncValue<void>> {
  CfoTaxNotifier() : super(const AsyncValue.data(null));
}
