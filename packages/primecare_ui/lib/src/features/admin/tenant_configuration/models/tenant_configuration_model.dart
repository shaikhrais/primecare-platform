class TenantConfigurationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TenantConfigurationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TenantConfigurationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TenantConfigurationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
