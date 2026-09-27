import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SocialMediaScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialMediaNotifier extends StateNotifier<AsyncValue<void>> {
  SocialMediaNotifier() : super(const AsyncValue.data(null));
}
