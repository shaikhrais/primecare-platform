class PswClientProfileModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswClientProfileModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswClientProfileModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswClientProfileModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
