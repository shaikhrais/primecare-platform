class RpnTasksModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RpnTasksModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RpnTasksModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RpnTasksModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
