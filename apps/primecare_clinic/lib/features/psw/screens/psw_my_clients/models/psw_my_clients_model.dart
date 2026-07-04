class PswMyClientsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswMyClientsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswMyClientsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswMyClientsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
