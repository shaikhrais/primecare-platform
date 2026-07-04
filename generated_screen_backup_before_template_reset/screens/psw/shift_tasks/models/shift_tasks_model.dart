class ShiftTasksModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ShiftTasksModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ShiftTasksModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ShiftTasksModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
