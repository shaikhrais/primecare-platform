class CommunicationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CommunicationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CommunicationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CommunicationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
