class CommunityOutreachEventsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CommunityOutreachEventsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CommunityOutreachEventsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CommunityOutreachEventsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
