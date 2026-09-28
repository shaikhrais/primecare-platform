// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Reviews
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceReviewsNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceReviewsNotifier() : super(const AsyncValue.data(null));
}
