class ClinicalTrialRecruitmentDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalTrialRecruitmentDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalTrialRecruitmentDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalTrialRecruitmentDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
