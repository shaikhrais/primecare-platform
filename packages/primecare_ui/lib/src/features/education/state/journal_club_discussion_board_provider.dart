import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Journal Club Discussion Board
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalClubDiscussionBoardNotifier extends StateNotifier<AsyncValue<void>> {
  JournalClubDiscussionBoardNotifier() : super(const AsyncValue.data(null));
}
