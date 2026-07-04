class CeoAlertsAndRisksModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoAlertsAndRisksModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoAlertsAndRisksModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoAlertsAndRisksModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
