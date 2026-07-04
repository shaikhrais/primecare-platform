class CtoInfrastructureModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CtoInfrastructureModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CtoInfrastructureModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CtoInfrastructureModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
