class PswClientsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswClientsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswClientsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswClientsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
