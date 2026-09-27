class ProtocolResolutionLogModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ProtocolResolutionLogModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ProtocolResolutionLogModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ProtocolResolutionLogModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
