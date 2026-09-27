class BlueprintSandboxModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BlueprintSandboxModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BlueprintSandboxModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BlueprintSandboxModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
