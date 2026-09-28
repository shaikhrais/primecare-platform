// Governance - Category: state | Purpose: Riverpod state notifier for Cto Feature Adoption
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CtoFeatureAdoptionNotifier extends StateNotifier<AsyncValue<void>> {
  CtoFeatureAdoptionNotifier() : super(const AsyncValue.data(null));
}
