class EcosystemStateBoardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EcosystemStateBoardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EcosystemStateBoardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EcosystemStateBoardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
