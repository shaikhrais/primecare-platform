class NursingTaskModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const NursingTaskModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  NursingTaskModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return NursingTaskModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
