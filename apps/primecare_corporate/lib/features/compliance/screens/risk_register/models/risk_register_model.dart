class RiskRegisterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RiskRegisterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RiskRegisterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RiskRegisterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
