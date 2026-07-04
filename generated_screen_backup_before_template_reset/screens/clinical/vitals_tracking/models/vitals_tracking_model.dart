class VitalsTrackingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VitalsTrackingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VitalsTrackingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VitalsTrackingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
