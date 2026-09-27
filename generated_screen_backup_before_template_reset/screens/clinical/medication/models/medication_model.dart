class MedicationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MedicationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MedicationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MedicationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
