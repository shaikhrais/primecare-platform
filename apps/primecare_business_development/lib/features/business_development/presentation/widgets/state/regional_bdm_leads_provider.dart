// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Leads
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmLeadsNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmLeadsNotifier() : super(const AsyncValue.data(null));
}
