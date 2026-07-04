class ConflictResolutionModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ConflictResolutionModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ConflictResolutionModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ConflictResolutionModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
