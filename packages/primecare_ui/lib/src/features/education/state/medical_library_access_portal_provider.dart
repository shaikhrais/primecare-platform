import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Medical Library Access Portal
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MedicalLibraryAccessPortalNotifier extends StateNotifier<AsyncValue<void>> {
  MedicalLibraryAccessPortalNotifier() : super(const AsyncValue.data(null));
}
