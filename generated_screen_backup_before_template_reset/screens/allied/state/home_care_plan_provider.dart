// Governance - Category: state | Purpose: Riverpod state notifier for HomeCarePlanScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeCarePlanNotifier extends StateNotifier<AsyncValue<void>> {
  HomeCarePlanNotifier() : super(const AsyncValue.data(null));
}
