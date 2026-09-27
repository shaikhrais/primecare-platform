class AgentDispatchModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AgentDispatchModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AgentDispatchModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AgentDispatchModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
