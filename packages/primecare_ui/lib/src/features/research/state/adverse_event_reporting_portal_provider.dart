// Governance - Category: state | Purpose: Riverpod state notifier for Adverse Event Reporting Portal
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdverseEventReportingPortalNotifier extends StateNotifier<AsyncValue<void>> {
  AdverseEventReportingPortalNotifier() : super(const AsyncValue.data(null));
}
