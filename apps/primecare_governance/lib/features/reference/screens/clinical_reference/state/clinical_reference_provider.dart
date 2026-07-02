// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Reference
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalReferenceNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalReferenceNotifier() : super(const AsyncValue.data(null));
}
