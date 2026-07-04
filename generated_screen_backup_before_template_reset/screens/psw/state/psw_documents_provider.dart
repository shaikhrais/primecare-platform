// Governance - Category: state | Purpose: Riverpod state notifier for Documents
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswDocumentsNotifier extends StateNotifier<AsyncValue<void>> {
  PswDocumentsNotifier() : super(const AsyncValue.data(null));
}
