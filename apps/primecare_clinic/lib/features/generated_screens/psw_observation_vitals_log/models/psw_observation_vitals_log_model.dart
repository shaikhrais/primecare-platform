class PswObservationVitalsLogModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswObservationVitalsLogModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswObservationVitalsLogModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswObservationVitalsLogModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
