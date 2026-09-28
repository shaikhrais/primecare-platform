// Governance - Category: state | Purpose: Riverpod state notifier for Community Outreach Follow Ups
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CommunityOutreachFollowUpsNotifier extends StateNotifier<AsyncValue<void>> {
  CommunityOutreachFollowUpsNotifier() : super(const AsyncValue.data(null));
}
