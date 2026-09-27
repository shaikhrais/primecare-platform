class CeoOrganizationMapModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoOrganizationMapModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoOrganizationMapModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoOrganizationMapModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
