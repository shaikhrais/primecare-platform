import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Data Privacy Monitor
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataPrivacyMonitorNotifier extends StateNotifier<AsyncValue<void>> {
  DataPrivacyMonitorNotifier() : super(const AsyncValue.data(null));
}
