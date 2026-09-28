// Governance - Category: state | Purpose: Riverpod state notifier for Community Outreach Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CommunityOutreachReportsNotifier extends StateNotifier<AsyncValue<void>> {
  CommunityOutreachReportsNotifier() : super(const AsyncValue.data(null));
}
