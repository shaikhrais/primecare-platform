class LeadConversionFunnelModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LeadConversionFunnelModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LeadConversionFunnelModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LeadConversionFunnelModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
