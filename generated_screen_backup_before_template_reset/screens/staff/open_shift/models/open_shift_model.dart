class OpenShiftModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OpenShiftModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OpenShiftModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OpenShiftModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
