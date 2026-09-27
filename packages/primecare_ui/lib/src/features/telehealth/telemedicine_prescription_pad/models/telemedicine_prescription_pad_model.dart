class TelemedicinePrescriptionPadModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TelemedicinePrescriptionPadModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TelemedicinePrescriptionPadModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TelemedicinePrescriptionPadModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
