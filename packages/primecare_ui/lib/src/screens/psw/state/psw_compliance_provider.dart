import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Psw Compliance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  PswComplianceNotifier() : super(const AsyncValue.data(null));
}
