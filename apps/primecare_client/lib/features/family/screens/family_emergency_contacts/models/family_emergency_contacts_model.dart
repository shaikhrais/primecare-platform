class FamilyEmergencyContactsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyEmergencyContactsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyEmergencyContactsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyEmergencyContactsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
