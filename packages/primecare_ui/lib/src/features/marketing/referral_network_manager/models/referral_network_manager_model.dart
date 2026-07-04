class ReferralNetworkManagerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ReferralNetworkManagerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ReferralNetworkManagerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ReferralNetworkManagerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
