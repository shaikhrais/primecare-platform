class TelehealthConsultationRoomModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TelehealthConsultationRoomModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TelehealthConsultationRoomModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TelehealthConsultationRoomModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
