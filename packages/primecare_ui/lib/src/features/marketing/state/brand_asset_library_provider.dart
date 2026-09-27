import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Brand Asset Library
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandAssetLibraryNotifier extends StateNotifier<AsyncValue<void>> {
  BrandAssetLibraryNotifier() : super(const AsyncValue.data(null));
}
