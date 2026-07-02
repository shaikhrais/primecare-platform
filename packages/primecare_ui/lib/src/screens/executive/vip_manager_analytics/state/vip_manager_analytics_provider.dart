// Governance - Category: state | Purpose: Riverpod state notifier for VIP Client Manager Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipManagerAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  VipManagerAnalyticsNotifier() : super(const AsyncValue.data(null));
}
