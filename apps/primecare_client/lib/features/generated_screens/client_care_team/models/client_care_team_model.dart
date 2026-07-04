class ClientCareTeamModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClientCareTeamModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClientCareTeamModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClientCareTeamModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
