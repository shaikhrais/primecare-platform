import 'package:primecare_models/primecare_models.dart';

class JournalClubDiscussionBoardModel extends BaseScreenState<JournalClubDiscussionBoardModel> {
  const JournalClubDiscussionBoardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  JournalClubDiscussionBoardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => JournalClubDiscussionBoardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
