class DocumentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DocumentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DocumentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DocumentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
