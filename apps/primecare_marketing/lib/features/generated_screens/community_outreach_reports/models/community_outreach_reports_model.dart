class CommunityOutreachReportsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CommunityOutreachReportsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CommunityOutreachReportsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CommunityOutreachReportsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
