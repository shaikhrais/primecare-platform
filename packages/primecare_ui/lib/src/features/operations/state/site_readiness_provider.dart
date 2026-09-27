import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Site Readiness
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SiteReadinessNotifier extends StateNotifier<AsyncValue<void>> {
  SiteReadinessNotifier() : super(const AsyncValue.data(null));
}
