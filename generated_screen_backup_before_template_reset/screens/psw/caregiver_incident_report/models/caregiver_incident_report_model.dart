class CaregiverIncidentReportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CaregiverIncidentReportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CaregiverIncidentReportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CaregiverIncidentReportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
