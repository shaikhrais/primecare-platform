class ServiceQualityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ServiceQualityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ServiceQualityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ServiceQualityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
