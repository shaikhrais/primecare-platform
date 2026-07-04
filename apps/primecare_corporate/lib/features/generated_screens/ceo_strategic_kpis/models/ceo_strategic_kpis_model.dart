class CeoStrategicKpisModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoStrategicKpisModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoStrategicKpisModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoStrategicKpisModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
