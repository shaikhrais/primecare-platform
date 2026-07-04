// Governance - Category: state | Purpose: Riverpod state notifier for LegalAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  LegalAnalyticsNotifier() : super(const AsyncValue.data(null));
}
