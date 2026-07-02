// Governance - Category: state | Purpose: Riverpod state notifier for CfoPayrollScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoPayrollNotifier extends StateNotifier<AsyncValue<void>> {
  CfoPayrollNotifier() : super(const AsyncValue.data(null));
}
