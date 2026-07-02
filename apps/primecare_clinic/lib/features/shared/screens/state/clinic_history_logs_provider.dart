// Governance - Category: state | Purpose: Riverpod state notifier for Clinic History Logs
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicHistoryLogsNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicHistoryLogsNotifier() : super(const AsyncValue.data(null));
}
