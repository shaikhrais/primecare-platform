import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for XrayReviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class XrayReviewNotifier extends StateNotifier<AsyncValue<void>> {
  XrayReviewNotifier() : super(const AsyncValue.data(null));
}
