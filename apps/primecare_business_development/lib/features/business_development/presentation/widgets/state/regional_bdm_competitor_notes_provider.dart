// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Competitor Notes
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RegionalBdmCompetitorNotesNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmCompetitorNotesNotifier() : super(const AsyncValue.data(null));
}
