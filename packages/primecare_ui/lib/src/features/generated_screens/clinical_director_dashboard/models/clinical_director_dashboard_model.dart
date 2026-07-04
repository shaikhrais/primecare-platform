class ClinicalDirectorDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalDirectorDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalDirectorDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalDirectorDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
