class ClinicalDirectorStaffingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalDirectorStaffingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalDirectorStaffingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalDirectorStaffingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
