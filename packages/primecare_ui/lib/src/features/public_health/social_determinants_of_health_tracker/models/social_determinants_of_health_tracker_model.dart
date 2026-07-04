class SocialDeterminantsOfHealthTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SocialDeterminantsOfHealthTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SocialDeterminantsOfHealthTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SocialDeterminantsOfHealthTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
