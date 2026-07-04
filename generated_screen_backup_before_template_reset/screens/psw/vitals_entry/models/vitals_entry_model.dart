class VitalsEntryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VitalsEntryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VitalsEntryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VitalsEntryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
