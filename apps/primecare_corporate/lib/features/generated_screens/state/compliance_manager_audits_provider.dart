// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Audits
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceManagerAuditsNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerAuditsNotifier() : super(const AsyncValue.data(null));
}
