// Governance - Category: state | Purpose: Riverpod state notifier for Coo Service Delivery
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooServiceDeliveryNotifier extends StateNotifier<AsyncValue<void>> {
  CooServiceDeliveryNotifier() : super(const AsyncValue.data(null));
}
