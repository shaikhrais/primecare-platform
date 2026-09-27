class RnTasksModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnTasksModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnTasksModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnTasksModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
