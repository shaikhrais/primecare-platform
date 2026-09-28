// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Document Expiry
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceManagerDocumentExpiryNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerDocumentExpiryNotifier() : super(const AsyncValue.data(null));
}
