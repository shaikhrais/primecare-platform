class DocumentExpiryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DocumentExpiryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DocumentExpiryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DocumentExpiryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
