class MultiCenterTrialCollaborationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MultiCenterTrialCollaborationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MultiCenterTrialCollaborationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MultiCenterTrialCollaborationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
