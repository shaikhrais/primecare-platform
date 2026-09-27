class MedicalLibraryAccessPortalModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MedicalLibraryAccessPortalModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MedicalLibraryAccessPortalModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MedicalLibraryAccessPortalModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
