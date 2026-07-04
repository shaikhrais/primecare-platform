class CtoFeatureAdoptionModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CtoFeatureAdoptionModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CtoFeatureAdoptionModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CtoFeatureAdoptionModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
