class RnCarePlansModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnCarePlansModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnCarePlansModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnCarePlansModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
