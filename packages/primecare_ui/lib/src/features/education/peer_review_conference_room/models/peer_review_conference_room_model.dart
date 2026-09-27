class PeerReviewConferenceRoomModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PeerReviewConferenceRoomModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PeerReviewConferenceRoomModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PeerReviewConferenceRoomModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
