// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Risk Register
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceManagerRiskRegisterNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerRiskRegisterNotifier() : super(const AsyncValue.data(null));
}
