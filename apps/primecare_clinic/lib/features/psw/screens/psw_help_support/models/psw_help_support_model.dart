class PswHelpSupportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswHelpSupportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswHelpSupportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswHelpSupportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
