class JournalClubDiscussionBoardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const JournalClubDiscussionBoardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  JournalClubDiscussionBoardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return JournalClubDiscussionBoardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
