// Governance - Category: state | Purpose: Riverpod state notifier for OfferManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfferManagementNotifier extends StateNotifier<AsyncValue<void>> {
  OfferManagementNotifier() : super(const AsyncValue.data(null));
}
