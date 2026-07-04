class ControlledSubstanceLogModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ControlledSubstanceLogModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ControlledSubstanceLogModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ControlledSubstanceLogModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
