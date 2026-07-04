class CorrectiveActionsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CorrectiveActionsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CorrectiveActionsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CorrectiveActionsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
