class DeviceIntegrationHubModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DeviceIntegrationHubModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DeviceIntegrationHubModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DeviceIntegrationHubModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
