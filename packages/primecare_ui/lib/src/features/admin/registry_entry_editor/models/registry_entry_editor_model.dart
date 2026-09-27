class RegistryEntryEditorModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegistryEntryEditorModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegistryEntryEditorModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegistryEntryEditorModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
