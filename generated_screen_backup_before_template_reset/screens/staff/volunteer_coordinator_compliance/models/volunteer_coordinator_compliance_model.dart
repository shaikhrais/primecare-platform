class VolunteerCoordinatorComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VolunteerCoordinatorComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VolunteerCoordinatorComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VolunteerCoordinatorComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
