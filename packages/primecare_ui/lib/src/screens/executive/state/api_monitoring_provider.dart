import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ApiMonitoringScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiMonitoringNotifier extends StateNotifier<AsyncValue<void>> {
  ApiMonitoringNotifier() : super(const AsyncValue.data(null));
}
