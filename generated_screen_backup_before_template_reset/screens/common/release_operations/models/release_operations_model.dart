class ReleaseOperationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ReleaseOperationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ReleaseOperationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ReleaseOperationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
