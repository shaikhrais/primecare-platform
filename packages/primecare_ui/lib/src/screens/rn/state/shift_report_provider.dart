// Governance - Category: state | Purpose: Riverpod state notifier for ShiftReportScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShiftReportNotifier extends StateNotifier<AsyncValue<void>> {
  ShiftReportNotifier() : super(const AsyncValue.data(null));
}
