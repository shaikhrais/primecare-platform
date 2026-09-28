// Governance - Category: state | Purpose: Riverpod state notifier for Document Expiry
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class DocumentExpiryNotifier extends StateNotifier<AsyncValue<void>> {
  DocumentExpiryNotifier() : super(const AsyncValue.data(null));
}
