class PswCommandCenterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswCommandCenterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswCommandCenterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswCommandCenterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
