class ResponsivePreviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResponsivePreviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResponsivePreviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResponsivePreviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
