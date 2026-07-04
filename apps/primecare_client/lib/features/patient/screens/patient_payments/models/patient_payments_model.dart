class PatientPaymentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PatientPaymentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PatientPaymentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PatientPaymentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
