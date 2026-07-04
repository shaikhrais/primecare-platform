class ServiceProcurementModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ServiceProcurementModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ServiceProcurementModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ServiceProcurementModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
