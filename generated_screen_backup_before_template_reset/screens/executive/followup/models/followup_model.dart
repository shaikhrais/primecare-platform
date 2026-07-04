class FollowupModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FollowupModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FollowupModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FollowupModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
