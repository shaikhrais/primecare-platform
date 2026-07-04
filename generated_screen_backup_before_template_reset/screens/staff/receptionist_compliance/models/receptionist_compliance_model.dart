class ReceptionistComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ReceptionistComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ReceptionistComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ReceptionistComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
