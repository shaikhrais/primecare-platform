class InpatientPharmacyQueueModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const InpatientPharmacyQueueModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  InpatientPharmacyQueueModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return InpatientPharmacyQueueModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
