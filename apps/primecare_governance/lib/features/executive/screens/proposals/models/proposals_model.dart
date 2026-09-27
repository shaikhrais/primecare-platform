class ProposalsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ProposalsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ProposalsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ProposalsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
