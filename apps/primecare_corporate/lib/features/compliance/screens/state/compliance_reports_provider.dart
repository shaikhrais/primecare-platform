// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceReportsNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceReportsNotifier() : super(const AsyncValue.data(null));
}
