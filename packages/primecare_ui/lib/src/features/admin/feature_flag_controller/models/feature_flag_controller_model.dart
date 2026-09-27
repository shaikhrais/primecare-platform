class FeatureFlagControllerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FeatureFlagControllerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FeatureFlagControllerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FeatureFlagControllerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
