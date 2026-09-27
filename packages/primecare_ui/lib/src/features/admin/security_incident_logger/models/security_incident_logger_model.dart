class SecurityIncidentLoggerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SecurityIncidentLoggerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SecurityIncidentLoggerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SecurityIncidentLoggerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
