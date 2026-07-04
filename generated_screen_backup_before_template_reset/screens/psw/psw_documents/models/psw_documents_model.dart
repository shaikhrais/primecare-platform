class PswDocumentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswDocumentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswDocumentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswDocumentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
