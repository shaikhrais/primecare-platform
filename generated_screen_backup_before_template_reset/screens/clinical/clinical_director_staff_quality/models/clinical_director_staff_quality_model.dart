class ClinicalDirectorStaffQualityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalDirectorStaffQualityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalDirectorStaffQualityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalDirectorStaffQualityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
