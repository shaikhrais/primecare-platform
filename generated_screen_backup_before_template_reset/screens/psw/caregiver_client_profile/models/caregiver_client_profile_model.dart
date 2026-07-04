class CaregiverClientProfileModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CaregiverClientProfileModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CaregiverClientProfileModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CaregiverClientProfileModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
