import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ComplianceManagerAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerAnalyticsNotifier() : super(const AsyncValue.data(null));
}
