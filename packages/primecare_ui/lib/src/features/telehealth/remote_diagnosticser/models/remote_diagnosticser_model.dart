class RemoteDiagnosticserModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RemoteDiagnosticserModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RemoteDiagnosticserModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RemoteDiagnosticserModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
