class OutpatientPrescriptionTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OutpatientPrescriptionTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OutpatientPrescriptionTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OutpatientPrescriptionTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
