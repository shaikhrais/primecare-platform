class RnMedicationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnMedicationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnMedicationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnMedicationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
