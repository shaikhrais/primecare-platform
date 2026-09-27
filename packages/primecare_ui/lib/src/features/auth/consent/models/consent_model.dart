class ConsentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ConsentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ConsentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ConsentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
