class PswIncidentReportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswIncidentReportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswIncidentReportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswIncidentReportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
