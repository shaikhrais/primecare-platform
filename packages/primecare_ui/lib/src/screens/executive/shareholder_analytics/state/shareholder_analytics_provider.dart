// Governance - Category: state | Purpose: Riverpod state notifier for ShareholderAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  ShareholderAnalyticsNotifier() : super(const AsyncValue.data(null));
}
