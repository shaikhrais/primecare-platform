import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for DocumentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentsNotifier extends StateNotifier<AsyncValue<void>> {
  DocumentsNotifier() : super(const AsyncValue.data(null));
}
