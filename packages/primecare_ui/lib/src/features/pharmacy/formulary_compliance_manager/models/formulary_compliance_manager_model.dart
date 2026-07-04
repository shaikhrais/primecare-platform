class FormularyComplianceManagerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FormularyComplianceManagerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FormularyComplianceManagerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FormularyComplianceManagerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
