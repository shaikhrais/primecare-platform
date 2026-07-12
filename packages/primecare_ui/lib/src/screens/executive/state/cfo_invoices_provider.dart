import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoInvoicesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoInvoicesNotifier extends StateNotifier<AsyncValue<void>> {
  CfoInvoicesNotifier() : super(const AsyncValue.data(null));
}
