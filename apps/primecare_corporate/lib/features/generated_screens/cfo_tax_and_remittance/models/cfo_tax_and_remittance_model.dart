class CfoTaxAndRemittanceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoTaxAndRemittanceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoTaxAndRemittanceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoTaxAndRemittanceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
