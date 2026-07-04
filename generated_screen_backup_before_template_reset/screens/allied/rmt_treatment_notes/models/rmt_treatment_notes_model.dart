class RmtTreatmentNotesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RmtTreatmentNotesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RmtTreatmentNotesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RmtTreatmentNotesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
