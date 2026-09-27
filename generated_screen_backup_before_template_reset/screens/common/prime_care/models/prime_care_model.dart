class PrimeCareModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PrimeCareModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PrimeCareModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PrimeCareModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
