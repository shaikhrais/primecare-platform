// Governance - Category: state | Purpose: Riverpod state notifier for Head Of Marketing Brand Assets
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HeadOfMarketingBrandAssetsNotifier extends StateNotifier<AsyncValue<void>> {
  HeadOfMarketingBrandAssetsNotifier() : super(const AsyncValue.data(null));
}
