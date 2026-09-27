class CoordinatorSosModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CoordinatorSosModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CoordinatorSosModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CoordinatorSosModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
