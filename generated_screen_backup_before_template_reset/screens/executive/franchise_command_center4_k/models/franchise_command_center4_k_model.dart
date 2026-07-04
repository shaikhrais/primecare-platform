class FranchiseCommandCenter4KModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseCommandCenter4KModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseCommandCenter4KModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseCommandCenter4KModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
