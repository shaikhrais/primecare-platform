import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ComplianceReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceReviewNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceReviewNotifier() : super(const AsyncValue.data(null));
}
