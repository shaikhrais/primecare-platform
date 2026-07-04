class MedicationAdministrationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MedicationAdministrationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MedicationAdministrationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MedicationAdministrationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
