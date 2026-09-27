class TrialDataCollectionCRFModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrialDataCollectionCRFModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrialDataCollectionCRFModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrialDataCollectionCRFModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
