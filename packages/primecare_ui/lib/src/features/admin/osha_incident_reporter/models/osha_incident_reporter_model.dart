class OshaIncidentReporterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OshaIncidentReporterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OshaIncidentReporterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OshaIncidentReporterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
