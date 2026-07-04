class EnterpriseHealthModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EnterpriseHealthModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EnterpriseHealthModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EnterpriseHealthModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
