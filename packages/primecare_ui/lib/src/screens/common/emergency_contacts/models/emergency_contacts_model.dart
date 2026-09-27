class EmergencyContactsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EmergencyContactsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EmergencyContactsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EmergencyContactsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
