import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Formulary Compliance Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormularyComplianceManagerNotifier extends StateNotifier<AsyncValue<void>> {
  FormularyComplianceManagerNotifier() : super(const AsyncValue.data(null));
}
