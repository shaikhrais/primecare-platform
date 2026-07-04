class RpnCommandCenterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RpnCommandCenterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RpnCommandCenterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RpnCommandCenterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
