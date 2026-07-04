class ClinicIncidentReportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicIncidentReportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicIncidentReportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicIncidentReportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
