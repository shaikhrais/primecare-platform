class IncidentReportsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IncidentReportsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IncidentReportsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IncidentReportsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
