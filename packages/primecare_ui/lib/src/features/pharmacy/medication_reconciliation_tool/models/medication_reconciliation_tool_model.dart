class MedicationReconciliationToolModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MedicationReconciliationToolModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MedicationReconciliationToolModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MedicationReconciliationToolModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
