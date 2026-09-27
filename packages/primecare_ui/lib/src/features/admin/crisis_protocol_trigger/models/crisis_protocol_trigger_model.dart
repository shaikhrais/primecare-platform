class CrisisProtocolTriggerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CrisisProtocolTriggerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CrisisProtocolTriggerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CrisisProtocolTriggerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
