class CeoEnterpriseOverviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoEnterpriseOverviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoEnterpriseOverviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoEnterpriseOverviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
