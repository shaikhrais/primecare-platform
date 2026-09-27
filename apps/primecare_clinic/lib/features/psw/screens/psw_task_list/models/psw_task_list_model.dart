class PswTaskListModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswTaskListModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswTaskListModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswTaskListModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
