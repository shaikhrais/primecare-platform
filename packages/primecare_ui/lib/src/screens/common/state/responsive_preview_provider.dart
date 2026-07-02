// Governance - Category: state | Purpose: Riverpod state notifier for ResponsivePreviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsivePreviewNotifier extends StateNotifier<AsyncValue<void>> {
  ResponsivePreviewNotifier() : super(const AsyncValue.data(null));
}
