class GamificationProfileModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const GamificationProfileModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  GamificationProfileModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return GamificationProfileModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
