// Governance - Category: state | Purpose: Riverpod state notifier for Local Marketing Manager Assets
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class LocalMarketingManagerAssetsNotifier extends StateNotifier<AsyncValue<void>> {
  LocalMarketingManagerAssetsNotifier() : super(const AsyncValue.data(null));
}
