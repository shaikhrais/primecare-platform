// Governance - Category: state | Purpose: Riverpod state notifier for CarePlanScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarePlanNotifier extends StateNotifier<AsyncValue<void>> {
  CarePlanNotifier() : super(const AsyncValue.data(null));
}
