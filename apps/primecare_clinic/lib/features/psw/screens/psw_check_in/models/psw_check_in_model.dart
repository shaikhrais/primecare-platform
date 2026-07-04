class PswCheckInModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswCheckInModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswCheckInModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswCheckInModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
