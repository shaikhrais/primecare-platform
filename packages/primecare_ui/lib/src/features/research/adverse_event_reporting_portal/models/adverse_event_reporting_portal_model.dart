class AdverseEventReportingPortalModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdverseEventReportingPortalModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdverseEventReportingPortalModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdverseEventReportingPortalModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
