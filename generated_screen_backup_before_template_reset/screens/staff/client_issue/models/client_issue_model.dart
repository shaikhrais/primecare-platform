class ClientIssueModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClientIssueModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClientIssueModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClientIssueModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
