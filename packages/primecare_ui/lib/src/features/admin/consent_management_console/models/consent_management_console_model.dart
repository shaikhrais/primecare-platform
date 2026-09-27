class ConsentManagementConsoleModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ConsentManagementConsoleModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ConsentManagementConsoleModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ConsentManagementConsoleModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
