// Governance - Category: state | Purpose: Riverpod state notifier for Partnership Manager Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  PartnershipManagerReportsNotifier() : super(const AsyncValue.data(null));
}
