// Governance - Category: state | Purpose: Riverpod state notifier for CarePlanReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarePlanReviewNotifier extends StateNotifier<AsyncValue<void>> {
  CarePlanReviewNotifier() : super(const AsyncValue.data(null));
}
