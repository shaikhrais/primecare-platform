class RegulatoryChangeRadarModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegulatoryChangeRadarModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegulatoryChangeRadarModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegulatoryChangeRadarModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
