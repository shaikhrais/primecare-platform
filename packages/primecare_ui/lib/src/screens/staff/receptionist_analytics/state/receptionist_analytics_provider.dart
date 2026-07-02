// Governance - Category: state | Purpose: Riverpod state notifier for ReceptionistAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistAnalyticsNotifier() : super(const AsyncValue.data(null));
}
