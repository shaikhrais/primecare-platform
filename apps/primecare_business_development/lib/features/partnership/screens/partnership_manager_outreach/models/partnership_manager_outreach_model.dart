class PartnershipManagerOutreachModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PartnershipManagerOutreachModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PartnershipManagerOutreachModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PartnershipManagerOutreachModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
