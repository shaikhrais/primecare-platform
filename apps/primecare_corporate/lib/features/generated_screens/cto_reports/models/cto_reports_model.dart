class CtoReportsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CtoReportsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CtoReportsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CtoReportsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
