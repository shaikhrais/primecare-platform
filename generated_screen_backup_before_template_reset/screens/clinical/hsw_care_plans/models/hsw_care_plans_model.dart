class HswCarePlansModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HswCarePlansModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HswCarePlansModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HswCarePlansModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
