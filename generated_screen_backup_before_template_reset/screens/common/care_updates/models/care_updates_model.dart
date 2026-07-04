class CareUpdatesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CareUpdatesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CareUpdatesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CareUpdatesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
