import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/journal_club_discussion_board_model.dart';

class JournalClubDiscussionBoardNotifier extends StateNotifier<JournalClubDiscussionBoardModel> {
  JournalClubDiscussionBoardNotifier() : super(const JournalClubDiscussionBoardModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final journal_club_discussion_boardProvider = StateNotifierProvider<JournalClubDiscussionBoardNotifier, JournalClubDiscussionBoardModel>((ref) {
  return JournalClubDiscussionBoardNotifier()..loadData();
});
