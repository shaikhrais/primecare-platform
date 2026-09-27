class IncidentResponseHubModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IncidentResponseHubModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IncidentResponseHubModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IncidentResponseHubModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
