class HeadOfBusDevComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HeadOfBusDevComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HeadOfBusDevComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HeadOfBusDevComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
