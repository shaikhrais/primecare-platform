// Governance - Category: state | Purpose: Riverpod state notifier for Hr Staff Files
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrStaffFilesNotifier extends StateNotifier<AsyncValue<void>> {
  HrStaffFilesNotifier() : super(const AsyncValue.data(null));
}
