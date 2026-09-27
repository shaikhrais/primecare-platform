import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Community Health Needs Assessment
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityHealthNeedsAssessmentNotifier extends StateNotifier<AsyncValue<void>> {
  CommunityHealthNeedsAssessmentNotifier() : super(const AsyncValue.data(null));
}
