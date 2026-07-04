class ScreenStatusModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ScreenStatusModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ScreenStatusModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ScreenStatusModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
