class ChiropractorTreatmentNotesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropractorTreatmentNotesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropractorTreatmentNotesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropractorTreatmentNotesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
