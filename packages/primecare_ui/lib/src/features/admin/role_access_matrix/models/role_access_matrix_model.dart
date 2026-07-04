class RoleAccessMatrixModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RoleAccessMatrixModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RoleAccessMatrixModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RoleAccessMatrixModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
