class RmtBillingLinkModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RmtBillingLinkModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RmtBillingLinkModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RmtBillingLinkModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
