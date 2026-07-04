class CaregiverVisitNotesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CaregiverVisitNotesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CaregiverVisitNotesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CaregiverVisitNotesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
