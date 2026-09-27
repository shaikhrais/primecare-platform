class AuditsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AuditsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AuditsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AuditsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
