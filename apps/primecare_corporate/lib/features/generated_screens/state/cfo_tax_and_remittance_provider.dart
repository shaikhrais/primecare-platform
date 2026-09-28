// Governance - Category: state | Purpose: Riverpod state notifier for Cfo Tax And Remittance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CfoTaxAndRemittanceNotifier extends StateNotifier<AsyncValue<void>> {
  CfoTaxAndRemittanceNotifier() : super(const AsyncValue.data(null));
}
