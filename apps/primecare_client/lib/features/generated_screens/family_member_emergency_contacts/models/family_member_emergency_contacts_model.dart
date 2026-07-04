class FamilyMemberEmergencyContactsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FamilyMemberEmergencyContactsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FamilyMemberEmergencyContactsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FamilyMemberEmergencyContactsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
