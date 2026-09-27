import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Competitor Analysis Board
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompetitorAnalysisBoardNotifier extends StateNotifier<AsyncValue<void>> {
  CompetitorAnalysisBoardNotifier() : super(const AsyncValue.data(null));
}
