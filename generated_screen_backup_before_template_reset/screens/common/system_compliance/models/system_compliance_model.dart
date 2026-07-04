class SystemComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SystemComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SystemComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SystemComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
