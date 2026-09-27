class SiteReadinessModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SiteReadinessModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SiteReadinessModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SiteReadinessModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
