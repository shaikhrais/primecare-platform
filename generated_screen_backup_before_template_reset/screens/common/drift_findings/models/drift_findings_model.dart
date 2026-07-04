class DriftFindingsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DriftFindingsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DriftFindingsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DriftFindingsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
