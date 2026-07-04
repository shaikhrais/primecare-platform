class ServiceIssueModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ServiceIssueModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ServiceIssueModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ServiceIssueModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
