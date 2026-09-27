class SecurityIncidentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SecurityIncidentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SecurityIncidentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SecurityIncidentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
