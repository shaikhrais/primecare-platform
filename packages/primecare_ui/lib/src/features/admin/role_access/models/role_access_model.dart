class RoleAccessModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RoleAccessModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RoleAccessModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RoleAccessModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
