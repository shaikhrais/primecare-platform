// Governance - Category: state | Purpose: Riverpod state notifier for QaAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  QaAnalyticsNotifier() : super(const AsyncValue.data(null));
}
