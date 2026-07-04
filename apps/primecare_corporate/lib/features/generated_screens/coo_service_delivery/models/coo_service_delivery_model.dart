class CooServiceDeliveryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooServiceDeliveryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooServiceDeliveryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooServiceDeliveryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
