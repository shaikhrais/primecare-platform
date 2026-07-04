class PharmacyInventoryManagementModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PharmacyInventoryManagementModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PharmacyInventoryManagementModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PharmacyInventoryManagementModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
