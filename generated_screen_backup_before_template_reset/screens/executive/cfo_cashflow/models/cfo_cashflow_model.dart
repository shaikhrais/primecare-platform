class CfoCashflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoCashflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoCashflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoCashflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
