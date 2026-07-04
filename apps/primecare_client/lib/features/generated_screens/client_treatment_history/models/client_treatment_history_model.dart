class ClientTreatmentHistoryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClientTreatmentHistoryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClientTreatmentHistoryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClientTreatmentHistoryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
