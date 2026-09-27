class PoliciesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PoliciesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PoliciesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PoliciesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
