// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmReportsNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmReportsNotifier() : super(const AsyncValue.data(null));
}
