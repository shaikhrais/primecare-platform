// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Nurse Specialist Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CnsAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  CnsAnalyticsNotifier() : super(const AsyncValue.data(null));
}
