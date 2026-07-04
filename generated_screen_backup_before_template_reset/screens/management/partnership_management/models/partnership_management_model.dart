class PartnershipManagementModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PartnershipManagementModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PartnershipManagementModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PartnershipManagementModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
