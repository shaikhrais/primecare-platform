// Governance - Category: state | Purpose: Riverpod state notifier for RnCarePlanReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnCarePlanReviewNotifier extends StateNotifier<AsyncValue<void>> {
  RnCarePlanReviewNotifier() : super(const AsyncValue.data(null));
}
