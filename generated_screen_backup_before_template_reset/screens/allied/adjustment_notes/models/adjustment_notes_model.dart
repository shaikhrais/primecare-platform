class AdjustmentNotesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdjustmentNotesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdjustmentNotesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdjustmentNotesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
