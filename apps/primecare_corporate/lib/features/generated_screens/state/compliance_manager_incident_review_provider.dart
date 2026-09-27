// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Incident Review
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerIncidentReviewNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerIncidentReviewNotifier() : super(const AsyncValue.data(null));
}
