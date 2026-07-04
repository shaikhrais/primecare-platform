class HrHiringOffersModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrHiringOffersModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrHiringOffersModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrHiringOffersModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
