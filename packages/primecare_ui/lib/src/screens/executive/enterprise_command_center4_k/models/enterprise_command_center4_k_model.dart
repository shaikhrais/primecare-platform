class EnterpriseCommandCenter4KModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EnterpriseCommandCenter4KModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EnterpriseCommandCenter4KModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EnterpriseCommandCenter4KModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
