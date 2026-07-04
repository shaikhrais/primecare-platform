class PartnershipManagerRenewalsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PartnershipManagerRenewalsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PartnershipManagerRenewalsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PartnershipManagerRenewalsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
