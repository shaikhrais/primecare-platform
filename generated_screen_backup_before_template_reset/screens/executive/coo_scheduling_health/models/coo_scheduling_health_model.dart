class CooSchedulingHealthModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooSchedulingHealthModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooSchedulingHealthModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooSchedulingHealthModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
