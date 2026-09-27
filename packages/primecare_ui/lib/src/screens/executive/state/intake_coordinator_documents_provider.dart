import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IntakeCoordinatorDocumentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorDocumentsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorDocumentsNotifier() : super(const AsyncValue.data(null));
}
