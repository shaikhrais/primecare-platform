import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for AuditReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditReviewNotifier extends StateNotifier<AsyncValue<void>> {
  AuditReviewNotifier() : super(const AsyncValue.data(null));
}
