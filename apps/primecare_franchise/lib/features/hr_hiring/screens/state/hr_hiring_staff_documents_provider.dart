// Governance - Category: state | Purpose: Riverpod state notifier for Hr Hiring Staff Documents
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringStaffDocumentsNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringStaffDocumentsNotifier() : super(const AsyncValue.data(null));
}
