class GovernanceOperations4KModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const GovernanceOperations4KModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  GovernanceOperations4KModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return GovernanceOperations4KModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
