class SystemHealthModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SystemHealthModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SystemHealthModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SystemHealthModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
