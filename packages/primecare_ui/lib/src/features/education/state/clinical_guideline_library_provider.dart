// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Guideline Library
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalGuidelineLibraryNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalGuidelineLibraryNotifier() : super(const AsyncValue.data(null));
}
