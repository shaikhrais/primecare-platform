class IncidentOversightModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IncidentOversightModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IncidentOversightModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IncidentOversightModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
